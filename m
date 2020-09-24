Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED94C2D0E2
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 14:01:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B123B20BED
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 14:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ui9d2C/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B123B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 609A986C2C;
	Thu, 24 Sep 2020 14:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jYeCUtwcz9js; Thu, 24 Sep 2020 14:01:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6382986B96;
	Thu, 24 Sep 2020 14:01:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 396BBC0889;
	Thu, 24 Sep 2020 14:01:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B954C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3FF8386BFA
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8hl4Tnjcl2QU for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 14:01:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D622986B96
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:01:35 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id j2so3942371wrx.7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PvtAp/gMbJp+plte2qkDTSFrKB4IybETEeiyFrm6dyE=;
 b=ui9d2C/njxa6HWTxaM30N36rzyTPPb87ZS5luf/VP8xxRj+4u8k/Xax6QyCNXSMZGd
 3KRT3tX0sYEJhOgqFrKQYqIOOSZDSf8Jf5F+eahDyO6svjlcUntWQ2JacrIVNmevrSb3
 BD5Qm2FoHGx0JZmhZY5XUzBFi1wu1GCOlf4OAglU9HrssNhtzh4EB0JoIjWVsdINJBgQ
 CxGcjw+qpfkrrkieP2VRJ1XCGZYmyDmk6ncV730AhG14O65D0878jndbweAofltNc4cx
 f+bnYgnZJeHqNv9OLa8kjhsxxNn9ae5eJ9iMei0iJJM0a8vuR0HJ2GUCp5+RFnOkF+9c
 k5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PvtAp/gMbJp+plte2qkDTSFrKB4IybETEeiyFrm6dyE=;
 b=qpoHVRMMI1IYnjEhk1Y58DHLzQA+/wEOW3flcSPYtF/tbzKPtOxNDHRj22RSRGHxEb
 1gL1o+6UyIb36JcQWOlMxsG0jzInFOa28bIEaxFpvsC/aHp9rpiQc2D/THCUAydUGYlg
 0P8rVNXC7E8LnsefVwFQZYaTRi4dEKzDIHQd0vSfCA/11el6zqV+vBgVIGpMYHMnFc4r
 aY8FLPVoAVmvqpcDAX8SmleEmO0vsXvteTsFOKYGH/qSUV4YMJW+79e5P944v2/wnbh8
 youYxM6qAcsrY6U8+UfVB3m7jTo7IZY7hUsPEKVK82FBWHkG2ezzjqzz6xTRjNZq5GCK
 Amyg==
X-Gm-Message-State: AOAM531Kps9g2H4lvVHTc0LNYaqzO5Xo5Oow2cwNLccykfexoQ6AK8uB
 u8sLQtsGf5jrp2zuoKwHk5I=
X-Google-Smtp-Source: ABdhPJxm41+NTdudwRk4qkWIOnJAoPI3MsHtF10Qpwy/AtTYga7ouFrdRG5QKjcga76IY1nE/d6jJQ==
X-Received: by 2002:adf:e802:: with SMTP id o2mr5187100wrm.309.1600956094093; 
 Thu, 24 Sep 2020 07:01:34 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id t17sm3718241wrx.82.2020.09.24.07.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 07:01:32 -0700 (PDT)
Date: Thu, 24 Sep 2020 16:01:30 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20200924140130.GA2527337@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <d3d69cb4-b0f9-40b0-b526-52fdc1a4b876@gmail.com>
MIME-Version: 1.0
In-Reply-To: <d3d69cb4-b0f9-40b0-b526-52fdc1a4b876@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2744833123206694863=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2744833123206694863==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:23:59PM +0300, Dmitry Osipenko wrote:
> 04.09.2020 15:59, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Reserved memory regions can be marked as "active" if hardware is
> > expected to access the regions during boot and before the operating
> > system can take control. One example where this is useful is for the
> > operating system to infer whether the region needs to be identity-
> > mapped through an IOMMU.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/reserved-memory/reserved-memory.txt           | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved=
-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-me=
mory.txt
> > index 4dd20de6977f..163d2927e4fc 100644
> > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory=
=2Etxt
> > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory=
=2Etxt
> > @@ -63,6 +63,13 @@ reusable (optional) - empty property
> >        able to reclaim it back. Typically that means that the operating
> >        system can use that region to store volatile or cached data that
> >        can be otherwise regenerated or migrated elsewhere.
> > +active (optional) - empty property
> > +    - If this property is set for a reserved memory region, it indicat=
es
> > +      that some piece of hardware may be actively accessing this regio=
n.
> > +      Should the operating system want to enable IOMMU protection for a
> > +      device, all active memory regions must have been identity-mapped
> > +      in order to ensure that non-quiescent hardware during boot can
> > +      continue to access the memory.
> > =20
> >  Linux implementation note:
> >  - If a "linux,cma-default" property is present, then Linux will use the
> >=20
>=20
> Hi,
>=20
> Could you please explain what devices need this quirk? I see that you're
> targeting Tegra SMMU driver, which means that it should be some pre-T186
> device.

Primarily I'm looking at Tegra210 and later, because on earlier devices
the bootloader doesn't consistently initialize display. I know that it
does on some devices, but not all of them. This same code should also
work on Tegra186 and later (with an ARM SMMU) although the situation is
slightly more complicated there because IOMMU translations will fault by
default long before these identity mappings can be established.

> Is this reservation needed for some device that has display
> hardwired to a very specific IOMMU domain at the boot time?

No, this is only used to convey information about the active framebuffer
to the kernel. In practice the DMA/IOMMU code will use this information
to establish a 1:1 mapping on whatever IOMMU domain that was picked for
display.

> If you're targeting devices that don't have IOMMU enabled by default at
> the boot time, then this approach won't work for the existing devices
> which won't ever get an updated bootloader.

If the devices don't use an IOMMU, then there should be no problem. The
extra reserved-memory nodes would still be necessary to ensure that the
kernel doesn't reuse the framebuffer memory for the slab allocator, but
if no IOMMU is used, then the display controller accessing the memory
isn't going to cause problems other than perhaps scanning out data that
is no longer a framebuffer.

There should also be no problem for devices with an old bootloader
because this code is triggered by the presence of a reserved-memory node
referenced via the memory-region property. Devices with an old
bootloader should continue to work as they did before. Although I
suppose they would start faulting once we enable DMA/IOMMU integration
for Tegra SMMU if they have a bootloader that does initialize display to
actively scan out during boot.

> I think Robin Murphy already suggested that we should simply create
> a dummy "identity" IOMMU domain by default for the DRM/VDE devices and
> then replace it with an explicitly created domain within the drivers.

I don't recall reading about that suggestion. So does this mean that for
certain devices we'd want to basically passthrough by default and then
at some point during boot take over with a properly managed IOMMU
domain?

The primary goal here is to move towards using the DMA API rather than
the IOMMU API directly, so we don't really have the option of replacing
with an explicitly created domain. Unless we have code in the DMA/IOMMU
code that does this somehow.

But I'm not sure what would be a good way to mark certain devices as
needing an identity domain by default. Do we still use the reserved-
memory node for that? That would still require some sort of flag to
specify which reserved-memory regions would need this identity mapping
because, as was pointed out in earlier review, some devices may have
reserved-memory regions that are not meant to be identity mapped.

> Secondly, all NVIDIA bootloaders are passing tegra_fbmem=3D... via
> kernel's cmdline with the physical location of the framebuffer in
> memory. Maybe we could support this option?

I'm not a big fan of that command-line option, but I also realize that
for older bootloaders that's probably the only option we have. I don't
suppose all of the devices support U-Boot? Because ideally we'd just
translate from tegra_fbmem=3D... to reserved-memory region there so that
we don't have to carry backwards-compatibility code for these purely
downstream bootloaders.

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9sprcACgkQ3SOs138+
s6E83RAAtbksMdpb/WjOX1mRTZMCHphwlHM8hmGCQYBF2sbzAaN17Uc0el1TiW+j
02ZpaFR4lc6CeDiGIw2bA9jAMmQrmxZHnjsrT4lrJ3X8lANGTBX87R2wzL87SzN+
Kdv1lMj4asVVXT8lrpTJGaho55dY3LV1ZjCKNLBsG8ABi6qzR/wxhts+X3brAfpA
mTy6eOrc+kDqqF8PW3THGSv64SF2a/kf/IOFxeS+8cIasWSad614lKh20WTQbHBE
x+VEY/ZjHc0tGY3fWUu7vieFSQLSDuEcPzBr21ZfUj/vCA20XIjP0xwmCdq/2YxV
UWT+YIvABIdZWoeoqsuDtMp1wBpA1OBICDbeDGb2as7lxZEgIxCfSNFlSv4ZraeB
W2+2CfbAdOX+unFJr4O5TZGnj25VQHCB9/Jy0Fzmj8KQUrR+g/71+urrUrJN4xzm
MetJLcnCwa7zeBAMTGA5QK1BjdB0Z1q7NT3BSEbSs6H0gecK3kFXJe/Z+qFX3zEC
Hx4kggwk6zgGQmXDS9EeCiaPqwABdRC5rWEu77piikvDgaMgcAgTinSX7N/85h3w
CxSKjUVUZsu/n1mSug+tT5m5SrosffBieLeSWflDgz4bbp5c90v8Ky2TuBJ684tS
22IYNc/yhqXbcMQrOPwnTDv1MQsK10ZO+eI1wrqQKMHjJGoFpFY=
=y4qb
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

--===============2744833123206694863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2744833123206694863==--
