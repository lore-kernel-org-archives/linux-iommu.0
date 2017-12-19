From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 5/5] iommu/vt-d: Add debugfs support for Interrupt
	remapping
Date: Tue, 19 Dec 2017 23:30:20 +0200
Message-ID: <1513719020.7000.234.camel@linux.intel.com>
References: <1513717687-82420-1-git-send-email-sohil.mehta@intel.com>
	<1513717687-82420-6-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1513717687-82420-6-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

On Tue, 2017-12-19 at 13:08 -0800, Sohil Mehta wrote:
> Debugfs extension for Intel IOMMU to dump Interrupt remapping table
> entries for Interrupt remapping and Interrupt posting.
> 
> The file /sys/kernel/debug/intel_iommu/ir_translation_struct provides
> detailed information, such as Index, Source Id, Destination Id, Vector
> and the raw values for entries with the present bit set, in the format
> shown.
> 
> Remapped Interrupt supported on IOMMU: dmar5
>  IR table address:ffff93e09d54c310
> -----------------------------------------------------------
>  Index  SID  Dest_ID  Vct Raw_value_high   Raw_value_low
>  1      3a00 00000600 2c  0000000000043a00 00000600002c0009
>  111    4301 00000900 a2  0000000000044301 0000090000a20009
> 
> Posted Interrupt supported on IOMMU: dmar5
>  IR table address:ffff93e09d54c310
> --------------------------------------------------------------------
>  Index  SID  PDA_high PDA_low  Vct Raw_value_high   Raw_value_low
>  4      4300 00000010 40c7c880 41  0000001000044300 40c7c88000418001
>  5      4300 00000010 40c7c880 51  0000001000044300 40c7c88000518001
> 
> 

> +		seq_printf(m, "\nRemapped Interrupt supported on
> IOMMU: %s\n"

Please, avoid leading \n.

> +			   " IR table address:%p\n", iommu->name,
> +			   iommu->ir_table);
> +
> +		seq_puts(m, "--------------------------------------
> ---------"
> +			 "------------\n");

It's okay to use long string literal on one line. So, don't split (or
for multi-line string literals, split by \n like you do above).

> +	seq_puts(m,
> "\n****\t****\t****\t****\t****\t****\t****\t****\n");

Leading \n.

> +		seq_printf(m, "\nPosted Interrupt supported on IOMMU:
> %s\n"

Ditto.

> +			   " IR table address:%p\n", iommu->name,
> +			   iommu->ir_table);
> +
> +		seq_puts(m, "--------------------------------------
> ----------"
> +			 "--------------------\n");

Join back.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
