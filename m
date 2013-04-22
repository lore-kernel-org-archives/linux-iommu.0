From: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH 1/1] intel-iommu: Disable DMA Remapping when
	intel_iommu=off
Date: Mon, 22 Apr 2013 16:06:45 +0900
Message-ID: <5174E185.1040806@jp.fujitsu.com>
References: <1366441080-5937-1-git-send-email-wei@aristanetworks.com>
	<5174CB26.9060908@jp.fujitsu.com>
	<CANwcMEZF+ehPeFuucRqcKSiNNoXL6bDy+GTHBHYjr3DfoZY7vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANwcMEZF+ehPeFuucRqcKSiNNoXL6bDy+GTHBHYjr3DfoZY7vg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: wei-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(2013/04/22 15:50), Wei Hu wrote:
> On Sun, Apr 21, 2013 at 10:31 PM, Takao Indoh
> <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
>> (2013/04/20 15:58), Wei Hu wrote:
>>> On a VT-d capable machine Linux will enable IOMMU by default. If it
>>> then kexec's a second kernel with intel_iommu=off, this second kernel
>>> will leave the DMA remapping engine on with no code handling it. The
>>> symptom is at least USB and SATA drives stop working. This patch fixes
>>> the problem by always disabling DMA remapping when intel_iommu=off.
>>
>> Even when second kernel boots up with intel_iommu=on, dma-remapping need
>> to be disabled as well before it is initialized and enabled again in
>> init_dmars(). So, how about something like this?
>>
>>          for_each_drhd_unit(drhd) {
>>                  struct dmar_drhd_unit *drhd;
>>                  if (drhd->ignored)
>>                          continue;
>>
>>                  iommu = drhd->iommu;
>>                  if (iommu->gcmd & DMA_GCMD_TE)
>>                          iommu_disable_translation(iommu);
>>          }
>>
>> Note, if you agree above code and fix your patch like this, you need
>> additinal fix to set iommu->gcmd flag sinse gcmd is always zero here.
>> See first hunk of this patch.
>> https://lkml.org/lkml/2013/3/20/707
> 
> Thanks for your reply. I reviewed your patch. Are you suggesting
> keeping your change to dmar.c, and moving your change to intel-iommu.c
> (i.e. the code you just showed) up after the call to
> dmar_table_init()?
> 
 
Yes, exactly.

Thanks,
Takao Indoh
