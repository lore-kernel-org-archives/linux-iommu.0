Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4963232;
	Sat, 28 Jan 2023 11:44:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 820BB424D0;
	Sat, 28 Jan 2023 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1674906285; bh=S5r0W0iw7BaFxUb16luLBBapLUJiOIdlxxM/yB90IPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uR8vs9F/g00tVM7iyiTjm8fYPy3+XyQGiV8UDAKDav9WMglXxeoMHPCLYC3NmDuvz
	 E36qupznzR7DP1lJq+73YD6EKtblden0Boa84/GTn1ochzWfS/BlnkZm8RW9flj17n
	 KsQ+UwW5CPK/Y/MMf9xv6JP8kyln2iZzrWuojLV6N7MnDk/mXmQUKTIMCNdeilD+il
	 SySdkGz0+8c+GcjpJSE5+nh2Wxae7fJmP5xLn02ACb0Vb4FERagvk4NOerOxRrWqfT
	 QmdJXSd91T1jUqqoB1B5U6xEkObJ9UrpzwCm38BvCq2mrmBgBnKPROhrLlvRFW8pm4
	 AZtzzvf0muGfQ==
Message-ID: <f2cfca4c-1728-f9eb-6e1e-56d7f4a1f637@marcan.st>
Date: Sat, 28 Jan 2023 20:44:39 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] dt-bindings: iommu: dart: Add t8103-usb4-dart
 compatible
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230128111114.4049-1-sven@svenpeter.dev>
 <20230128111114.4049-2-sven@svenpeter.dev>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20230128111114.4049-2-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2023 20.11, Sven Peter wrote:
> This DART variant is found in the t8103 (M1) SoCs and used for the
> USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
> up to 64 SIDs and require a slightly different MMIO layout. This variant
> is only found on the M1 SoCs.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> index 903edf85d72e..f9c1843c074d 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> @@ -24,6 +24,7 @@ properties:
>    compatible:
>      enum:
>        - apple,t8103-dart
> +      - apple,t8103-dart-usb4
>        - apple,t8110-dart
>        - apple,t6000-dart
>  

You probably wanted t8103-usb4-dart (as mentioned in the commit message).

Other than that,

Acked-by: Hector Martin <marcan@marcan.st>

- Hector
