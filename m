Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0A746A
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 19:36:06 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id p185so10998987oif.2
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 11:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKVjqRKStPGtyEwxaCj0ohxNvc0dxIuOgOWql908gkw=;
        b=JsYKx17ZHpLi0pvYbiHMDCWqumZ5SzxWe1g2s4hejRwRv5DUD6M9Glz/FrVKHlaMvF
         NPFsiwJgYY89EBAxBm5yaH83VXp579deWlWgufkuAr6fgcS4R/66xxEtsoupQkswTEmd
         Rqhzw7e4O5+bWJUEcHElYmHoWi2gtjTBkb0RdtH57x4s9kQNsrRmubCAVfyDtHszmvCP
         p8FD5Qcn1Kk0cFcFLynm2fx7dXfJE8xhsbHBdJRSwNyrpfVUNxawjOsKvQOMr3mHsoAx
         9yA6F+4xlRuuwWXrCTu3tx/1yUqlwv1Kl8AEhBYtFD680ihSs9+y+Seka0GeQp4FnH/v
         Ek6Q==
X-Gm-Message-State: AO0yUKWUs6B6uS4VIfj7soE+Cm8IBX93L07iCgFibtnOmJNn/Bb0cYCO
	6dpovTLSXarSbJ+feH777g==
X-Google-Smtp-Source: AK7set8Xx+4mi4emwLZhw3UeJydWN4cYJGg8ng23OdVmGBjhpJJ1GllfU+NXxN5Ixqzu/eb7vn+eJw==
X-Received: by 2002:a05:6808:ab9:b0:378:69f4:7f6c with SMTP id r25-20020a0568080ab900b0037869f47f6cmr1129358oij.43.1675107366043;
        Mon, 30 Jan 2023 11:36:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h18-20020a9d61d2000000b0068bd9a6d644sm735279otk.23.2023.01.30.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:36:05 -0800 (PST)
Received: (nullmailer pid 3233511 invoked by uid 1000);
	Mon, 30 Jan 2023 19:36:04 -0000
Date: Mon, 30 Jan 2023 13:36:04 -0600
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Update
 descriptions for R-Car Gen4
Message-ID: <20230130193604.GA3218335-robh@kernel.org>
References: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdX92KMeON0xC9p17kiqWT7ksEBX_NyPiiQk0fLaucDZBA@mail.gmail.com>
 <TYBPR01MB5341B023178B4A10DE52B844D8CE9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <CAMuHMdXXnu88Tn2ucuHZK=3G18v-nCfaTYpomchRXBu3bD7UuA@mail.gmail.com>
 <3c3e1dc2-1f66-565c-c677-2eae368e10be@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3e1dc2-1f66-565c-c677-2eae368e10be@arm.com>

On Wed, Jan 25, 2023 at 10:42:13AM +0000, Robin Murphy wrote:
> On 2023-01-25 08:54, Geert Uytterhoeven wrote:
> > Hi Shimoda-san,
> > 
> > On Wed, Jan 25, 2023 at 1:49 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > From: Geert Uytterhoeven, Sent: Tuesday, January 24, 2023 11:35 PM
> > > > On Mon, Jan 23, 2023 at 2:35 AM Yoshihiro Shimoda
> > > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > > Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, but
> > > > > each cache IPMMU has own module id. So, update descriptions of
> > > > > renesas,ipmmu-main property for R-Car Gen4.
> > > > > 
> > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > > > > ---
> > > > >   The old R-Car S4-8 datasheet had described IPMMU IMSSTR register, but
> > > > >   the latest datasheet undocumented the register. So, update the propeties
> > > > >   description. Note that the second argument is not used on the driver.
> > > > 
> > > > DT describes hardware, not software policy.
> > > 
> > > I think so.
> > > 
> > > > >   So no behavior change.
> > > > 
> > > > So where do we get the module id numbers to use, if they are no longer
> > > > documented in the Hardware Manual?
> > > 
> > > If so, we cannot get the module id numbers. So, should we use other
> > > information which is completely fixed instead? I have some ideas:
> > > 1) Just 0 (or other fixed value) if the IMSSTR register doesn't exist.
> > > 2) Sequential numbers from register base offset.
> > >     In R-Car S4: ipmmu_rt0 is the first node from register base offset,
> > >     and ipmmu_rt1 is the second one.
> > >     So, ipmmu_rt0 is 0, ipmmu_rt1 is 1, ipmmu_ds0 is 2 and ipmmu_hc is 3.
> > > 3) Using base address upper 16-bits.
> > >     In R-Car S4: ipmmu_rt0 is 0xee480000. So, the value is 0xee48.
> > > 
> > > Perhaps, the option 1) is reasonable, I think. But, what do you think?
> > 
> > I would not make up numbers, as that would cause confusion with SoCs
> > where the numbers do match the hardware.
> > As the driver doesn't use the module id number (it already loops
> > over all domains, instead of checking IMSSTR, probably because of
> > historical (R-Car Gen2) reasons?), what about dropping it from the
> > property? I.e. add "minItems: 1", possibly only when compatible with
> > renesas,rcar-gen4-ipmmu-vmsa?
> 
> Right, if there really is no meaningful ID for this model then its binding
> should not require one.

I agree, however that makes parsing the property a pain (for both the 
schema and driver). This property is a matrix. The number of entries is 
already variable. If both dimensions are variable, we have to then look 
at the compatible to know how to parse it. I would go with option 1.

A 4th option is a new property.

Rob
