From: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Subject: Re: trying to figure out why VT-d isn't working on my kernel -- solved
Date: Wed, 14 Mar 2012 10:48:07 -0700
Message-ID: <20120314174807.GB27235@sequoia.sous-sol.org>
References: <4F56E728.8020506@genband.com>
 <4F593792.1070909@genband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F593792.1070909-b7o/lNNmKxtBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chris Friesen <chris.friesen-b7o/lNNmKxtBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

* Chris Friesen (chris.friesen-b7o/lNNmKxtBDgjK7y7TUQ@public.gmane.org) wrote:
> On 03/06/2012 10:42 PM, Chris Friesen wrote:
> >I've got a current (pulled today) kernel running on a Xeon E5-2648L CPU
> >on an Intel motherboard, and I'm trying to get VT-d working without much success.
> >
> >lspci -vv (version 3.1.4) doesn't show anything related to IOV.
> >(Full output below.)  Since I know the I350 devices are capable of virtual
> >functions, am I correct in assuming it's something similar to the situation
> >described at https://bugzilla.redhat.com/show_bug.cgi?id=652210 and there is
> >a problem with my BIOS?  Based on comment 15 there, the fact that all
> >the DevCtl2 lines show "ARIFwd-" seems interesting.
> >
> >Among other things, I've enabled the following in the kernel config:
> >
> >CONFIG_DMAR_TABLE=y
> >CONFIG_INTEL_IOMMU=y
> >CONFIG_INTEL_IOMMU_DEFAULT_ON=y
> >CONFIG_PCI_MSI=y
> >CONFIG_PCI_STUB=y
> >CONFIG_PCI_IOV=y
> 
> Just in case anyone else runs into this, it turns out that enabling
> CONFIG_PCI_MMCONFIG allowed the virtual functions to be detected and
> configured.

Yeah, you need to be able to access PCI Extended Configuration Space to
enable SR-IOV.

thanks,
-chris
