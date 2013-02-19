From: Diana Craciun <diana.craciun@freescale.com>
Subject: Re: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Tue, 19 Feb 2013 17:59:37 +0200
Message-ID: <5123A169.9060100@freescale.com>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com> <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, scottwood@freescale.com, joro@8bytes.org, stuart.yoder@freescale.com
List-Id: iommu@lists.linux-foundation.org

On 02/18/2013 02:52 PM, Varun Sethi wrote:
> +/**
> + * pamu_get_ppaace() - Return the primary PACCE
> + * @liodn: liodn PAACT index for desired PAACE
> + *
> + * Returns the ppace pointer upon success else return
> + * null.
> + */
> +static struct paace *pamu_get_ppaace(int liodn)
> +{
> +	if (!ppaact || liodn > PAACE_NUMBER_ENTRIES) {

Shouldn't be "liodn >= PAACE_NUMBER_ENTRIES" ?

> +		pr_err("PPAACT doesn't exist\n");
> +		return NULL;
> +	}
> +
> +	return &ppaact[liodn];
> +}
> +

Diana
