From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Tue, 12 May 2015 14:18:52 +0800
Message-ID: <20150512061852.GA10229@dhcp-16-116.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> This patchset is an update of Bill Sumner's patchset, implements a fix for:
> If a kernel boots with intel_iommu=on on a system that supports intel vt-d, 
> when a panic happens, the kdump kernel will boot with these faults:

Test passed on my local workstation. Thanks, Zhenhua.

> 
>     dmar: DRHD: handling fault status reg 102
>     dmar: DMAR:[DMA Read] Request device [01:00.0] fault addr fff80000
>     DMAR:[fault reason 01] Present bit in root entry is clear
> 
>     dmar: DRHD: handling fault status reg 2
>     dmar: INTR-REMAP: Request device [[61:00.0] fault index 42
>     INTR-REMAP:[fault reason 34] Present field in the IRTE entry is clear
