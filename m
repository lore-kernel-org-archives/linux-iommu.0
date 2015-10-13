From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4] iommu/arm-smmu: Add support for MSI on SMMUv3
Date: Tue, 13 Oct 2015 19:48:29 +0100
Message-ID: <20151013184829.GH24353@leverpostej>
References: <1444757550-24702-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444757550-24702-1-git-send-email-marc.zyngier-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -36,5 +36,25 @@ the PCIe specification.
>                        NOTE: this only applies to the SMMU itself, not
>                        masters connected upstream of the SMMU.
>  
> +- msi-parent	    : phandles (and potential Device IDs) of MSI controllers


For correct terminology, I'd prefer to replace this line with:

- msi-parent: a list of phandle + msi-specifier pairs for MSI controllers

An msi-specifier may be zero cells, per
Documentation/devicetree/bindings/interrupt-controller/msi.txt, much
like other *-specifiers.

> +		      the SMMU can send MSIs to (instead of wired interrupts).
> +		      See devicetree/bindings.interrupt-controller/msi.txt
> +		      for a description of the msi-parent property.

The rest of this is fine, modulo the '.' which should be a '/'. in the
path.

With those changes:

Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Thanks,
Mark.
