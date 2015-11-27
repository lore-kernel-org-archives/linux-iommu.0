From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v2 7/9] iommu/amd: copy old tables and do not update dev
	tables before driver init
Date: Fri, 27 Nov 2015 12:35:17 +0100
Message-ID: <20151127113517.GF24300@8bytes.org>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
	<1446811851-20623-8-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446811851-20623-8-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 06, 2015 at 08:10:49PM +0800, Baoquan He wrote:
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Missing patch description.

> ---
>  drivers/iommu/amd_iommu.c      | 19 +++++------
>  drivers/iommu/amd_iommu_init.c | 71 ++++++++++++++++++++++++------------------
>  2 files changed, 49 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 48bcd83..90c6205 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1992,14 +1992,15 @@ static void do_attach(struct iommu_dev_data *dev_data,
>  	/* Update data structures */
>  	dev_data->domain = domain;
>  	list_add(&dev_data->list, &domain->dev_list);
> -	set_dte_entry(dev_data->devid, domain, ats);
> +	if (!translation_pre_enabled()) {
> +		set_dte_entry(dev_data->devid, domain, ats);
> +		/* Flush the DTE entry */
> +		device_flush_dte(dev_data);
> +	}

Hmm, this patch adds a lot of special cases into the AMD IOMMU code to
make sure the domain is attached at driver init time.

Can we change the code to generally defer domain attachment to driver
init time? There is a set_dma_mask call-back in the dma-ops that can be
used for that.

This would limit the special cases to device table initialization and
iommu enable time.

> +	if ( !translation_pre_enabled()) {
> +		if (flags & ACPI_DEVFLAG_INITPASS)
> +			set_dev_entry_bit(devid, DEV_ENTRY_INIT_PASS);
> +		if (flags & ACPI_DEVFLAG_EXTINT)
> +			set_dev_entry_bit(devid, DEV_ENTRY_EINT_PASS);
> +		if (flags & ACPI_DEVFLAG_NMI)
> +			set_dev_entry_bit(devid, DEV_ENTRY_NMI_PASS);
> +		if (flags & ACPI_DEVFLAG_SYSMGT1)
> +			set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT1);
> +		if (flags & ACPI_DEVFLAG_SYSMGT2)
> +			set_dev_entry_bit(devid, DEV_ENTRY_SYSMGT2);
> +		if (flags & ACPI_DEVFLAG_LINT0)
> +			set_dev_entry_bit(devid, DEV_ENTRY_LINT0_PASS);
> +		if (flags & ACPI_DEVFLAG_LINT1)
> +			set_dev_entry_bit(devid, DEV_ENTRY_LINT1_PASS);
> +
> +		amd_iommu_apply_erratum_63(devid);
> +	}

This bothers, will the flags still get set when translation is
pre-enabled?


	Joerg
