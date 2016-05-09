From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Set AMD iommu callbacks for platform bus driver
Date: Mon, 9 May 2016 18:16:55 +0200
Message-ID: <20160509161655.GF13971@8bytes.org>
References: <1460640533-3025-1-git-send-email-vincent.wan@amd.com>
	<20160509102041.GA13275@8bytes.org>
	<8c4cc9fc-26df-759e-6630-7bab927cf01b@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8c4cc9fc-26df-759e-6630-7bab927cf01b-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Cc: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 09, 2016 at 08:17:12PM +0800, Wan Zongshun wrote:
> Currently, Only New eMMC driver will rely on this sdhci-acpi.c, but
> I could not find a suitable ifdef XXX micro to limit this
> platform_bus_type here like AMBA bus type before.
> 
> Do you think this MMC_SDHCI_ACPI is ok?

Okay, looks like platform_bus_type does not depend on any config-symbol.
So the patch is fine, but please add a comment why the iommu-ops are
needed on the platform bus.


	Joerg
