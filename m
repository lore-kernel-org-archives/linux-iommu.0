Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE24405;
	Thu, 13 Oct 2022 18:17:39 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id l22so3775213edj.5;
        Thu, 13 Oct 2022 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7qwPUEZ1ZhfA+wANlCjEKHD1jlsyDHPilB/I6xGaZA=;
        b=OwfkBRBgr2PFFLhPYms8BwxXSG4Fc/fK8EqoqLMWxXrxwEZH0zChQpuSzaJVWYum/F
         EWYmiYq6Hh1IlFL04YmRQRLZ8SCSU3l9AlL5NDc5LzM9kvEGaYBXnhegk5/Q0E1OUZko
         MnphSpSgbFutzcpwWwyxMmJjA9d9m+d/zCpfxzmvEZzce+tVvPdGp7fcdyZq1dM33ry6
         Ur1QrDlMMv6P/i17YtvM+PtLl/wjMlPc5OmIsMoUpbnE/TiXYxrpIIpb9j8JBLWyXOVC
         ZpI6fmspp6+uOtN6tYPSkl3/Vt/ztk3Z8LpFlx43HtrhhTudENtKQjlBd8yE7z43pn6D
         4JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7qwPUEZ1ZhfA+wANlCjEKHD1jlsyDHPilB/I6xGaZA=;
        b=GKUHy3UErjfLnf9XHV5g8BxQRDbZ0TlAINSSgYykSjRRwty55Q71YZHllrhWDBtnVM
         IjO0I7lmQzRXgpQX4r/MxTfwcW8qLSiZrDXD+Xj8cUVN4NIBqZdTijWVDnkNzoj0DNu6
         G+BAX0EMS44VuExs2MMhEHpjorHozmJaEoh0KowVUUlQugjgUamQRsFm4ac5Xg80TxOp
         MIL0TyUNauVwEbKARDV2qqtdGKb4pHCpqv0dZqqxnQQ5tq85ykWyUCVoWWNFOIhmwph/
         WQnTYWFNDkGP7W6227xLo4m1DRhaSQmOmrLzGSl1Ayo90hh8MZeJR8/GFtgdWn5zqFsL
         6cRQ==
X-Gm-Message-State: ACrzQf1SuGeJ/tFzI24avN2CzS9tfmIYNnuzltEwNQkpEMci1YWUs6Qu
	61N+8lXzdC2g0klDSNM6n14=
X-Google-Smtp-Source: AMsMyM4tW50WsdxGOymGeUSqnL5oRfzwxkZiFV1zFdsjDVrLwel/HsNrBGerF0BdB9iwstFH+FQueA==
X-Received: by 2002:a05:6402:5252:b0:45d:d1a:fe7d with SMTP id t18-20020a056402525200b0045d0d1afe7dmr815908edd.323.1665685058029;
        Thu, 13 Oct 2022 11:17:38 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id v25-20020aa7dbd9000000b00456c6b4b777sm222778edt.69.2022.10.13.11.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:17:37 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: maxime@cerno.tech, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, wens@csie.org, samuel@sholland.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iommu/sun50i: Invalidate iova at map and unmap
Date: Thu, 13 Oct 2022 20:17:36 +0200
Message-ID: <3161965.AJdgDx1Vlc@kista>
In-Reply-To: <20221013181221.3247429-6-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com> <20221013181221.3247429-6-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 13. oktober 2022 ob 20:12:20 CEST je Jernej Skrabec napis=
al(a):
> Mapped and unmapped iova addresses needs to be invalidated immediately
> or otherwise they might or might not work when used by master device.
>=20
> This was discovered when running video decoder conformity test with
> Cedrus. Some videos were now and then decoded incorrectly and generated
> page faults.
>=20
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Please ignore this patch. It's same as next one, with slightly different co=
mmit=20
message.


