Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F81859;
	Sun,  8 Jan 2023 20:54:05 +0000 (UTC)
Received: by mail-il1-f175.google.com with SMTP id o13so3982882ilc.7;
        Sun, 08 Jan 2023 12:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKnNpQNdzdLgMMqd20StxieGNrz33GPSfX+GftpfArA=;
        b=Oq7cxz7adr+itqKzQt6xpAb9Cv6UQwGHww9aGksKmyZxx+TPnhd+N3X19Vf14r1C3D
         mjLLjjIuAD5gqsFOR3nNApGnq6EN/BR5Z2f6EEG4gpm4q4xqppKRZUW9m1lWumv5mpIZ
         IT/R27v+6nyudRLGmgjiq3vXWlgSgm2Me1YjQfK0EAmTSP5rqudg7Pzh9UOdnrxB7Daf
         V4UlaDzdITLd3xZz+fprLXmKab9JNUTnpIG9+qxx//9ciWTOzXPHCzYDgiPZ98KA9RBm
         rRj2KeYhlIDnnpsb0kkipDgV6LPm2A9e6em8S/r6WYDF7L8GuwM8oAf3G92t+EvReWmF
         Sb2A==
X-Gm-Message-State: AFqh2kpMBv+UBF+wkUIx0lP4ZsKAvZazFtsrIXOzz30ioyrqtkHekboU
	qyIg96m7muicyVkyvaJ6OA==
X-Google-Smtp-Source: AMrXdXuD97K0zSgLYBr6hvBS4jKAj99eoH7O0k7hsPy3oE3DQWUsf0GqPtn1v6cmHrUEnMgWWMuQTQ==
X-Received: by 2002:a92:dd83:0:b0:300:a953:a263 with SMTP id g3-20020a92dd83000000b00300a953a263mr49546522iln.21.1673211244943;
        Sun, 08 Jan 2023 12:54:04 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id z18-20020a92d6d2000000b003039e7d680fsm2257683ilp.11.2023.01.08.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:54:04 -0800 (PST)
Received: (nullmailer pid 260770 invoked by uid 1000);
	Sun, 08 Jan 2023 20:53:43 -0000
Date: Sun, 8 Jan 2023 14:53:43 -0600
From: Rob Herring <robh@kernel.org>
To: Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: sun50i: Add compatible for
 Allwinner D1
Message-ID: <167321122261.260695.4785173456346736432.robh@kernel.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-2-samuel@sholland.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103010903.11181-2-samuel@sholland.org>


On Mon, 02 Jan 2023 19:08:58 -0600, Samuel Holland wrote:
> D1 contains an IOMMU similar to the one in the H6 SoC, but the D1
> variant has no external reset signal.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Disallow the 'resets' property for the D1 variant
> 
>  .../iommu/allwinner,sun50i-h6-iommu.yaml      | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
