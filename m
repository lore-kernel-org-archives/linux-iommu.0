From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 0/9] iommu/vt-d: Improve PASID id and table management
Date: Wed, 16 May 2018 16:01:00 +0800
Message-ID: <5AFBE53C.2070604@linux.intel.com>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
	<20180515141101.GF18595@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180515141101.GF18595-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thank you for looking at my patches.

On 05/15/2018 10:11 PM, Joerg Roedel wrote:
> On Fri, May 04, 2018 at 09:41:15AM +0800, Lu Baolu wrote:
>> PATCH 4~9 implement per domain PASID table. Current per IOMMU
>> PASID table implementation is insecure in the cases where
>> multiple devices under one single IOMMU unit support PASID
>> feature. With per domain PASID table, we can achieve finer
>> protection and isolation granularity.
>
> Hold on, we hat discussions in the past about doing a system-wide pasid
> space, so that every mm_struct with devices attached gets the same pasid
> across all devices it is talking to. Reason was that some devices (will)
> require this to work correctly. This goes into the opposite direction,
> so I am a bit confused here. Please explain, is this not longer
> necessary?

You are right. System-wide pasid space is necessary, hence PATCH
1~3 implement it. But PATCH 4~9 don't go into the opposite direction,
it's designed to address another potential issue.

With system-wide pasid space, we can use a system-wide pasid table,
or just keep what we have now(per iommu unit pasid table). Both
system-wide and per iommu unitpasid table mean that two devices
might share a single pasid table. That will result in an issue.

For an example, device A is assigned to access the memory space of
process A, and device B is assigned to access the memory space of
process B. The dma remapping infrastructure looks like:

                                                     .------------------.
                             .----------------.      |                  |
                             |                |      |                  |
                             .----------------.      | Paging structure |
                             |     PASID X    |--|   |  for Process A   |
                             .----------------.  |   |                  |
                             |                |  --->'------------------'
     .----------------.      .----------------.
     |                |      |     PASID Y    |--|
     .----------------.      .----------------.  |
     | Dev_A context  |---|  |                |  |   .------------------.
     '----------------'   |  .----------------.  |   |                  |
     |                |   |  |                |  |   |                  |
     '----------------'   |  .----------------.  |   | Paging structure |
     | Dev_B context  |   -->|                |  |   |  for Process B   |
     '----------------'----->'----------------'  |   |                  |
     |                |         system-wide      v-->'------------------'
     .----------------.         pasid table    
     |                |                        
     '----------------'
        Intel iommu
       context table


Since dev_A and dev_B share a pasid table, the side effect is that a flawed
dev_A might access the memory space of process B (with pasid y). Vice versa,
a flawed dev_B might access memory space of process A (with pasid x).

What PATCH 4~9 do is to remove such possibility by assigning a pasid table
for each pci device. Hence, the remapping infrastructure looks like:


                                                    .------------------.
                                                    |                  |
                            .----------------.      |                  |
                            |                |      | Paging structure |
                            .----------------.      |  for Process A   |
                            |     PASID X    |      |                  |
                            .----------------.----->'------------------'
                            |                |
                            .----------------.
                            |                |
                            .----------------.
                            |                |
                            .----------------.
   .----------------.       |                |
   |                |       .----------------.
   .----------------.       |                |
   | Dev_A context  |------>'----------------'
   '----------------'          pasid table 
   |                |          for Dev_A   
   '----------------'                      
   | Dev_B context  |-->
   '----------------'  |    .----------------.
   |                |  |    |                |      .------------------.
   .----------------.  |    .----------------.      |                  |
   |                |  |    |                |      |                  |
   '----------------'  |    .----------------.      | Paging structure |
       Intel iommu     |    |                |      |  for Process B   |
      context table    |    .----------------.      |                  |
                       |    |     PASID Y    |----->'------------------'
                       |    .----------------.
                       |    |                |
                       |    .----------------.
                       |    |                |
                       |    .----------------.
                       v--->|                |
                            '----------------'
                               pasid table 
                               for Dev_B   
                                           

With this, dev_A has no means to access memory of process B and vice versa.

Best regards,
Lu Baolu
