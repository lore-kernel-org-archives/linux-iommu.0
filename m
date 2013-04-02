From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Wed, 3 Apr 2013 00:09:32 +0200
Message-ID: <20130402220931.GV30540@8bytes.org>
References: <1364929514-3129-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1364929514-3129-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

On Tue, Apr 02, 2013 at 02:05:14PM -0500, Suthikulpanit, Suravee wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> +static const char * const _type_field_encodings[] = {
> +	/* 00 */"Reserved",
> +	/* 01 */"Master Abort",
> +	/* 10 */"Target Abort",
> +	/* 11 */"Data Error",

In these arrays, please put the comments at the end of the line and
align them nicely like this:

	static const char * const _type_field_encodings[] = {
		"Reserved",		/* 00 */
		"Master Abort",		/* 01 */
		"Target Abort",		/* 10 */
		"Data Error",		/* 11 */
	};

This improves readability a lot.

> +static void dump_flags(int flags, int ev_type)
> +{
> +	struct _event_log_flags *p = (struct _event_log_flags *) &flags;
> +	u32 err_type = p->type;
> +
> +	pr_err("AMD-Vi: Flags details: %s, NX:%u, %s, %s, %s, %s, %s, %s, %s\n",
> +		(p->gn ? "Use guest address" : "Use nested address"),
> +		(p->nx),
> +		(p->us ? "User privileges" : "Supervisor privileges"),
> +		(p->i ? "Interrupt request" : "memory request"),
> +		(p->pr ? "Page present or Interrupt remapped" :
> +			"Page not present or Interrupt blocked"),
> +		(p->rw ? "Write transaction" : "Read transaction"),
> +		(p->pe ? "Does not have permission" : "Has permission"),
> +		(p->rz ? "Reserv bit not zero" : "Illegal level encoding"),
> +		(p->tr ? "Translation request" : "Transaction request"));

These strings are too long, please just print useful shortcuts for them,
like
	"US" : "SV" instead of
	"User privileges" : "Supervisor privileges"

Also the commas between the strings are not needed then.

As a general rule, in the default configuration an event-log entry
should not take more than a single line in dmesg (which is also not too
long). If you want to print more information in some cases you can
enable that by a command line parameter like 'amd_iommu=verbose' or
something like that.

	Joerg
