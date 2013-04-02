From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Tue, 2 Apr 2013 16:33:36 +0200
Message-ID: <20130402143335.GB15687@8bytes.org>
References: <1364428283-2548-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1364428283-2548-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Suravee,

On Wed, Mar 27, 2013 at 06:51:23PM -0500, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> 
> Add logic to decode AMD IOMMU event flag based on information from AMD IOMMU specification.
> This should simplify debugging IOMMU errors.  Also, dump DTE information in additional cases.

The patch in general makes sense to have, but I have a couple of
comments.

> +static void dump_flags(int flags, int ev_type)
> +{
> +	struct _event_log_flags *p = (struct _event_log_flags *) &flags;
> +	u32 err_type = p->type;
> +
> +	pr_err("AMD-Vi: Flags details:\n");
> +	pr_err("AMD-Vi:    Guest / Nested  : %u\n", p->gn);
> +	pr_err("AMD-Vi:    No Execute      : %u\n", p->nx);
> +	pr_err("AMD-Vi:    User-Supervisor : %u\n", p->us);
> +	pr_err("AMD-Vi:    Interrupt       : %u\n", p->i);
> +	pr_err("AMD-Vi:    Present         : %u\n", p->pr);
> +	pr_err("AMD-Vi:    Read / Write    : %u\n", p->rw);
> +	pr_err("AMD-Vi:    Permission      : %u\n", p->pe);
> +	pr_err("AMD-Vi:    Reserv bit not zero / Illegal level encoding : %u\n",
> +		p->rz);
> +	pr_err("AMD-Vi:    Translation / Transaction : %u\n",
> +		p->tr);
> +	pr_err("AMD-Vi:    Type of error   : (0x%x) ", err_type);

Printing the flags multi-line is much too noisy for IOMMU events. Just
print a char-shortcut for each flag set on the same line.

> +
> +	if ((ev_type == EVENT_TYPE_DEV_TAB_ERR)  ||
> +	    (ev_type == EVENT_TYPE_PAGE_TAB_ERR) ||
> +	    (ev_type == EVENT_TYPE_CMD_HARD_ERR)) {
> +		/* Only supports up to 2 bits */
> +		err_type &= 0x3;
> +		switch (err_type) {
> +		case 0:
> +			pr_err("Reserved\n");
> +			break;
> +		case 1:
> +			pr_err("Master Abort\n");
> +			break;
> +		case 2:
> +			pr_err("Target Abort\n");
> +			break;
> +		case 3:
> +			pr_err("Data Error\n");
> +			break;
> +		}

Why do you create string-arrays for other type-encodings but not for
this one?

> +	} else if (ev_type == EVENT_TYPE_INV_DEV_REQ) {
> +		if (p->tr == 0) {
> +			if (err_type < ARRAY_SIZE(_invalid_translation_desc))
> +				printk("%s\n",
> +					_invalid_translation_desc[err_type]);
> +		} else {
> +			if (err_type < ARRAY_SIZE(_invalid_transaction_desc))
> +				printk("%s\n",
> +					_invalid_transaction_desc[err_type]);

pr_cont instead of printk.


	Joerg
