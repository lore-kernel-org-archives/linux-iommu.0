From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v6 3/5] iommu/vt-d: Add debugfs support to show register
	contents
Date: Wed, 10 Jan 2018 15:35:39 +0200
Message-ID: <1515591339.7000.863.camel@linux.intel.com>
References: <1515556102-34150-1-git-send-email-sohil.mehta@intel.com>
	<1515556102-34150-4-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1515556102-34150-4-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2018-01-09 at 19:48 -0800, Sohil Mehta wrote:

> Debugfs extension to dump all the register contents for each IOMMU
> device to the user space via debugfs.
> 
> example:
> root@OTC-KBLH-01:~# cat /sys/kernel/debug/intel_iommu/iommu_regset
> 
> DMAR: dmar1: reg_base_addr fed90000
> Name         Offset     Contents
> VER          0x00       0x0000000000000010
> CAP          0x08       0x01c0000c40660462
> ECAP         0x10       0x0000019e2ff0505e
> GCMD         0x18       0x0000000000000000
> GSTS         0x1c       0x00000000c7000000
> RTADDR       0x20       0x00000004558d6800
> CCMD         0x28       0x0800000000000000
> FSTS         0x34       0x0000000000000000
> FECTL        0x38       0x0000000000000000
> FEDATA       0x3c       0xfee0100c00004141

> +		seq_printf(m, "\nDMAR: %s: reg_base_addr %llx\n",
> iommu->name,
> +			   base);

Can we get rid of leading '\n'?

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
