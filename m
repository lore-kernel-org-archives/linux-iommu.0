Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A720F9
	for <iommu@lists.linux.dev>; Mon,  8 May 2023 17:18:13 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-965cc5170bdso665043166b.2
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683566291; x=1686158291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPLrilJOpAfCtWH73NaWni8pY2sG/Rz0VNe7OUxyQPg=;
        b=QBa5klLYRx6s5xUdv17wPOIXHSVMOnDCRRV+kMDzkp10mpOn414lUE7CKd2DD5xOlG
         TEDhSJgzAMKYbKS0U31N33AjJY6Yiwr0vbD2vo93Z1FHmSMqjtWDTXsrR4Jnoq2ooFvj
         v5sCzUMeR+r8Gj8N3ozf7y2nYwYqTJ44YIFS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566291; x=1686158291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPLrilJOpAfCtWH73NaWni8pY2sG/Rz0VNe7OUxyQPg=;
        b=XNxEqw4uTl9GTlAzHJOMX7Avx3nmXc3c3xM4ndOair3KToyeWcnt2bbv4xWDz9Lsgt
         8B4YSANP1c1Fp7EqTJGulOMAcwSTfEG4uDnJj2zTFISpSUf5uNhGEI7EBDF7YN1qDz1W
         sT6B0QAWDKiaMGmg5j+R5KEfHMaJcsY7lES5GLKSGA9LgU2MQ4/WLxYITcBQB+A6vHwg
         4fxM/TdHwiHHkBdh1w/V5uIQbarAGIgOhYgXvnU7OtgYzt59Ql3/uEotCooOPFtfKuT9
         2FOWYqssDL0fjNJpiuTGk8eYW+5/rMWWfP+kQAPcjab/Qk9j6+PrZahkMZpulOEoqE/9
         alGg==
X-Gm-Message-State: AC+VfDxmZUL7F826cD4/++abSdKYAlt1Pktvk1wmLDygESt+X1Ryx173
	BAlZi9HZZEGN3xC606XXZlGutvzMOkNzmZOy5+xNiw==
X-Google-Smtp-Source: ACHHUZ4MUU1kssiM7vAZ0Nu0IP80OcD0DFRGq2U/0coByoXXibqtpeXT5aj800MiJZbJ5krBzG14/w==
X-Received: by 2002:a17:907:7fa2:b0:932:4255:5902 with SMTP id qk34-20020a1709077fa200b0093242555902mr10808206ejc.76.1683566291535;
        Mon, 08 May 2023 10:18:11 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id ml23-20020a170906cc1700b0094ea3a32694sm201957ejb.190.2023.05.08.10.18.10
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:18:11 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so7667083a12.1
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 10:18:10 -0700 (PDT)
X-Received: by 2002:a17:907:2cc4:b0:94f:3338:12a2 with SMTP id
 hg4-20020a1709072cc400b0094f333812a2mr9978465ejc.33.1683566290229; Mon, 08
 May 2023 10:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
 <20230506150741.2e3d2dcc@jacob-builder> <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
 <20230508094014.53913cf3@jacob-builder> <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
 <ZFkpk8y8mUZuZjkV@nvidia.com>
In-Reply-To: <ZFkpk8y8mUZuZjkV@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 May 2023 10:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
Message-ID: <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>, 
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, 
	"Yu, Fenghua" <fenghua.yu@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 8, 2023 at 9:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> CONFIG_IOMMU_MM_PASID perhaps? Says what it does without a clue about
> why it does it. x86 arch code could select it ideally?

Maybe we don't even need the "IOMMU" part. It's a core x86
architecture feature. Maybe it usually (always?) gets used within the
framework of some IOMMU work, but I guess ENCQCMD could be used in
some hardwired way even without that (ie is it possible to have just
some "basic PASID set up by VMM environment" thing?)

I don't actually know who uses it and how, so I'm probably not the
right person to name it, but just looking at the x86 code that sets
it, the PASID code technically has no connection to any iommu code,
it's literally a core CPU feature with an MSR and some magic faulting
thing, and seems to be possibly usable as-is.

That existing

    #ifdef CONFIG_IOMMU_SVA

in the x86 traps.c code just looks odd, and making it be
CONFIG_IOMMU_MM_PASID sounds better to me. I'm just not sure about the
"IOMMU" part either. Just "MM_PASID"?

That said, the arm-smmu-v3-sva.c code clearly *also* uses pasid,
except it seems to really want to call it "ssid".

So "having a per-mm ASID for IO" is clearly a common feature. But
naming seems hard, with x86 calling it PASID, arm64 seemingly calling
it "SSID".

Right now the only user *does* seem to be through the IOMMU SVA code,
but that may or may not be fundamental.

Now, "SSID" is a completely horrible name, as I immediately realized
when I tried to google for it. So arm64 is just wrong, and we're most
definitely continuing to call it PASID.

I'd lean towards just "CONFIG_MM_PASID" or something, but at some
point this is bikeshedding, and I don't know about any possible
non-iommu direct uses?

           Linus
