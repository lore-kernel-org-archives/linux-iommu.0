Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006E259C
	for <iommu@lists.linux.dev>; Sat,  6 May 2023 15:43:28 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-965a68abfd4so550880066b.2
        for <iommu@lists.linux.dev>; Sat, 06 May 2023 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683387807; x=1685979807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K3NrRKSl6ilP3fnwAsx1m0nufJ3hRrCfj2tW9kJ2I4=;
        b=DT/UBCdZcGLy77JEJK1IxwS4Lv5Cz+QZKRq6ZIH7htdhcGgr24zh8dfD1YAGiAQUSL
         yK4pzXaLN2azYKa1KF4ZI0uYyLFSODMITlLXN8D/GbfHpgVfJ/o+Tq5MoX4Wl0UYQLFY
         kobjejyfUVPq65+eGuGOPxHCnHJmmGm/xQXlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683387807; x=1685979807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K3NrRKSl6ilP3fnwAsx1m0nufJ3hRrCfj2tW9kJ2I4=;
        b=Dw4rlRUlPWvix79NMAZXkQxP2B3q/fkx7Q47Rs1+drg2LDZc3t1vsb7tPfcmkS2Efz
         SdMfl1UZ3zgKu6ApWhpH2WC44utlkz9FlGRQChhXbpgH2oEARPYXQLQ1RK8qXbjosjTv
         0FfFJABIl+eKccj/Lj5uzv2F6mmd4GPZynxLrOXK9CFYj394JCIGkDiLU5OC2tqNxtm7
         YJnACLaxVrG9HeLXezbiJeMGKEYHK5w17Yg34rgIbIZBcHb44BPqvjX+2YF1yFKannn/
         x50MyHchPBlP2BakyEVinUm1hj2/dWrkxh4UkhLc3XWRToz1FbObLYGq3HowV0CXCBS6
         cVpw==
X-Gm-Message-State: AC+VfDzicS8BYiWgppZ+7dv8g8twYR0WBvdmD3bLECXDqe9UI+/UzxOF
	lhCsgmSZsRBpwgRKkv7sAnHVXv46lMwNivBWG+Q8LA==
X-Google-Smtp-Source: ACHHUZ5VefoFueCkd8bW+z/UFFLMH4Mp7V/nocF9vq12SAmLLwZLsiolbFXSIyr1qSbzGDtSH66E4Q==
X-Received: by 2002:a17:906:eeca:b0:965:d17b:292 with SMTP id wu10-20020a170906eeca00b00965d17b0292mr3855579ejb.60.1683387807019;
        Sat, 06 May 2023 08:43:27 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id nr1-20020a1709068b8100b00966069b78absm1245899ejc.192.2023.05.06.08.43.25
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 08:43:25 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso5277760a12.3
        for <iommu@lists.linux.dev>; Sat, 06 May 2023 08:43:25 -0700 (PDT)
X-Received: by 2002:a17:907:74c:b0:953:37eb:7727 with SMTP id
 xc12-20020a170907074c00b0095337eb7727mr4516381ejb.43.1683387805125; Sat, 06
 May 2023 08:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 May 2023 08:43:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
Message-ID: <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>, 
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, 
	"Yu, Fenghua" <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 6, 2023 at 6:27=E2=80=AFAM Jacob Pan <jacob.jun.pan@linux.intel=
.com> wrote:
>
> Shared Virtual Addressing (SVA) is not immediately intuitive to people
> who work outside IOMMU subsystem, add some explanation to make it less
> opaque.

So the patch has at least two problems.

The first is that you corrupted the SPDX line.

But the second is that the change from

-       bool
+       bool "Shared Virtual Addressing"

means that now Kconfig *asks* about this thing, which was never the
intent. The other Kconfig options that need it all do a

        select IOMMU_SVA

to get it picked.

I suspect that's why it then causes errors - because now the test
robot can enable the option even in situations where it makes no sense
and doesn't work.

So no, it's not that the option needs a help entry that can be queried
at Kconfig time. It's that the option needs a name that makes sense
and isn't some random jumble of letters that is only understandable to
people who already know exactly what it is.

               Linus
