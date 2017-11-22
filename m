From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Add debugfs extension to show
	register contents
Date: Wed, 22 Nov 2017 23:19:19 +0200
Message-ID: <1511385559.25007.415.camel@linux.intel.com>
References: <1511378746-109275-1-git-send-email-sohil.mehta@intel.com>
	<1511378746-109275-5-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1511378746-109275-5-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

On Wed, 2017-11-22 at 11:25 -0800, Sohil Mehta wrote:
> From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


> +static int intel_iommu_regs_open(struct inode *inode, struct file
> *file)
> +{
> +	return single_open(file, intel_iommu_debugfs_regs_show,
> +			   inode->i_private);
> +}
> +
> +static const struct file_operations intel_iommu_regs_fops = {
> +	.open		= intel_iommu_regs_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};

Please, be consistent with file name and functions, i.e.

intel_iommu_debugfs_regs_show -> intel_iommu_regset_show

and so on.

Moreover, see the patch I have just sent [1] and use same
DEFINE_SHOW_ATTRIBUTE() macro here. In that case we would easily move it
to seq_file.h for everyone to use in the future.

> +	if (!debugfs_create_file("intel_iommu_regset", S_IRUGO,
> +				 iommu_debug_root, NULL,
> &intel_iommu_regs_fops

[1]: https://marc.info/?l=linux-bluetooth&m=151138535801354&w=2
 

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
