Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4EF33D1;
	Mon, 13 Feb 2023 13:23:19 +0000 (UTC)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
	id 946FD26F77F; Mon, 13 Feb 2023 14:23:15 +0100 (CET)
Date: Mon, 13 Feb 2023 14:23:15 +0100
From: Janne Grunau <j@jannau.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 07/17] dt-bindings: iommu: apple,sart: Add
 apple,t8112-sart compatible string
Message-ID: <20230213132315.GC17933@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-7-cb5442d1c229@jannau.net>
 <6e18ab3a-512e-ffe2-1c88-9b57bd1d3960@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e18ab3a-512e-ffe2-1c88-9b57bd1d3960@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On 2023-02-13 12:13:55 +0100, Krzysztof Kozlowski wrote:
> On 12/02/2023 16:41, Janne Grunau wrote:
> > "apple,t8112-sart" as found on the Apple M2 SoC appears to be SART3 as
> > well. To allow for later discovered incompatibilities use
> > '"apple,t8112-sart", "apple,t6000-sart"' as compatible string.
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > 
> > ---
> > This trivial dt-bindings update should be merged through the asahi-soc
> > tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> > series.
> 
> Same comment as in other cases.

dropped from all commits and cover letter.

> > ---
> >  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> > index 1524fa3094ef..07d2d68a87df 100644
> > --- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> > @@ -28,9 +28,14 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - apple,t6000-sart
> > -      - apple,t8103-sart
> > +    oneOf:
> > +      - items:
> > +          - const: apple,t8112-sart
> > +          - const: apple,t6000-sart
> > +      - items:
> 
> Drop items.

done

> > +          enum:
> > +            - apple,t6000-sart
> > +            - apple,t8103-sart
> >  
> >    reg:
> >      maxItems: 1
> > 

thanks

