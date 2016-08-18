From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 09/15] drivers: acpi: iort: add support for ARM SMMU
	platform devices creation
Date: Thu, 18 Aug 2016 11:55:04 +0100
Message-ID: <20160818105452.GA8982@red-moon>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1471274620-20754-10-git-send-email-lorenzo.pieralisi@arm.com>
	<20160818105005.GA20404@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160818105005.GA20404-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, nd-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 18, 2016 at 06:50:07PM +0800, Dennis Chen wrote:

[...]

> > +static void __init iort_smmu_init(void)
> > +{
> > +	struct acpi_iort_node *iort_node, *iort_end;
> > +	struct acpi_table_iort *iort;
> > +	struct fwnode_handle *fwnode;
> > +	int i, ret;
> > +
> > +	/*
> > +	 * table and iort will both point to the start of IORT table, but
> > +	 * have different struct types
> > +	 */
> > +	iort = (struct acpi_table_iort *)iort_table;
> >
> If the firmware of a platform happens to miss the IORT table, then
> iort_table here will be a NULL pointer, in this case 'NULL pointer
> dereference' kernel panic will occur, if this is not an expected
> behavior then we can add a sanity check here to avoid this.  IORT
> missing is a fatal error? I don't think so.

Yes, I've already fixed it, thanks for pointing that out.

Lorenzo
