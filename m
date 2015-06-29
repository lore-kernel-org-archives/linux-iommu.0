From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Ignore -ENODEV errors from add_device call-back
 returning -ENODEV
Date: Mon, 29 Jun 2015 15:43:19 +0200
Message-ID: <20150629134319.GJ18569@8bytes.org>
References: <1435237844-25004-1-git-send-email-m.szyprowski@samsung.com>
 <20150629083534.GG18569@8bytes.org>
 <55910797.7090709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55910797.7090709@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Inki Dae <inki.dae@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 29, 2015 at 10:53:43AM +0200, Marek Szyprowski wrote:
> On 2015-06-29 10:35, Joerg Roedel wrote:
> >The -ENODEV error just means that the device is not
> >translated by an IOMMU. We shouldn't bail out of iommu
> >driver initialization when that happens, as this is a common
> >scenario on ARM.
> >
> >No returning -ENODEV in the drivers would be a bad idea, as
> >the IOMMU core would have no indication whether a device is
> >translated or not. This information is not used at the
> >moment, but will probably be in the future.
> >
> >Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> Works fine!
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for testing! The patch is queued now.
