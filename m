From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 11/23] driver core: add per device iommu param
Date: Mon, 14 May 2018 13:52:08 -0700
Message-ID: <20180514135208.51987d8f@jacob-builder>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-12-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF91E31.9060705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5AF91E31.9060705-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 14 May 2018 13:27:13 +0800
Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> Hi,
> 
> On 05/12/2018 04:54 AM, Jacob Pan wrote:
> > DMA faults can be detected by IOMMU at device level. Adding a
> > pointer to struct device allows IOMMU subsystem to report relevant
> > faults back to the device driver for further handling.
> > For direct assigned device (or user space drivers), guest OS holds
> > responsibility to handle and respond per device IOMMU fault.
> > Therefore we need fault reporting mechanism to propagate faults
> > beyond IOMMU subsystem.
> >
> > There are two other IOMMU data pointers under struct device today,
> > here we introduce iommu_param as a parent pointer such that all
> > device IOMMU data can be consolidated here. The idea was suggested
> > here by Greg KH and Joerg. The name iommu_param is chosen here
> > since iommu_data has been used.  
> 
> This doesn't match what you've done in the patch. Maybe you
> forgot to cleanup? :-)
> 
No, I was trying to explain the thought process behind naming
iommu_param. I meant to say iommu_data is a probably a better name but
taken already.
> The idea is to create a parent pointer under device struct and
> move previous iommu_group and iommu_fwspec together with
> the iommu fault related data into it.
> 
> Best regards,
> Lu Baolu
> 
>  [...]  
> 

[Jacob Pan]
