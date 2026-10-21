Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608448;
	b=32V5AhOMJI/htQ+MohzNfAHJExMrXqecHfnAjpjOVVYqBkAxKpp+vUmpVH504Tsqp+0s
	 5wbVHtpKGk1VbTlagFWyNBIbSNvBEDLdk3sMo6fkem0OeeosjpqFkMajCNV2U5Ul10KXC
	 /L0pveaHVPRbl50gmXR0mp5fxpuTlW9SqZvV78Pu6svYEfq3+qC7U9uQOQcZzg04t6DNv
	 afjqwGN1tHf0Wph9lTKJexTw0iV5y0W4ht+eqDThnKPHE6f3IUm3uK/gdahBSn4jucoZY
	 Re2yDljmli7KBeA5cjS3cP1Zxs/sYT8oPZf3fLWFOIhQSqodnrW/Gyv8HZ+E6ug1Luw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
	b=sM2sWH3eKZYGcrlG7XtnD/ltbibc6viY7pvPwcGyP1J/CEaf0y6IY7wBfMDQ1SRwSt7C
	 bzl0llO3H4PmhvNcSOKnsQYZN1QKu6d/QBNCchruDvfHz3hje3SWlfQ3vxNITYltokCCs
	 MfNgVOvSs1deD09xZChVy5o3TwiHYlmgIkNHkV8mNwSp6hsn9h7892gs9m5AocLBp5TWi
	 HkGX0QDEsYjogpjIk3udgSHKlDgZyp2IuRQyI7wM+FXk+DsqQiJ870IxCmcDFds/283QY
	 uopS6t+uFXNSPegezy93YTyQzreyG1yvmwnWi+PbMtgv5WpyZpeJM/lJcQIiZASAr7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="D/qqbsnX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F685606A320
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 18:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F685606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=D/qqbsnX
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-353804b591eso1994579eec.0
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 11:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608447; cv=none;
        d=google.com; s=arc-20260327;
        b=DRBBZjkS8c62l0gOk07SyO96wru0ZpMycgkLtVDbFn/xeC3fSxVV70QdqIRSwJSoqS
         1GuQoajmaQGpsiXAUFdAG+Rk8cB7YIJwGusgEMRVkcwzqlwTt921J0vovUGNvYUSrRM+
         vdxBnZq1XuyicjSVDE7oFazLIcjcy4TKTNxeQHSln6Pe5qtifYeBLGAHhRg1LbeP62hE
         lbS2AyCXCAKvqZayjBvHNEfv56PdRjDo/FXLus1J7ddsE9eN7lWQQBwh2EpOzCAOiAIb
         0k7IXHghoW3Ev0rncbg4kCqDCooha+MRkU7FPG2GNsy4Rot4/P9GQuFZmK8/BILSZlt9
         iCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        fh=G6NEwKXbKzKctxLY6i8NJW75nJEQEA6egi6Kwo7+vTI=;
        b=F9oGqZ/JfZ4cP0RAKwSLldhm95lDI5nmxejaiiJRU8OcsLruGWgEp+0xlciz2rFXTu
         97knSv9tV7AWEDvpquiwbEqxJUycZebXSrvYcOoQZ1NOZo18OksGVPPRS0q637QNEOOg
         H82lQkHlRrJD0CKlPHoXoSXqSAdjEpJFKPCLF3KjZx5kVzoGiQioVZbxHQwSbMZTzJkV
         kT6Kw1Gzp0v727Cn9lQFMg+YlSIHMwTTrO+4+KyUyTdeO5y/CnbxhReg8jblrFPzP1Pr
         4SFJunoCpwCpFAU85Bx0OiNnidFYIakrEij973qwDAkMQyOjO91bINfisJ6Jeki18oDK
         ZFwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792608447; x=1793213247; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=D/qqbsnX5FCnopxWv8JRdV4QCO71RQSnClwYHATFx7CtvWwY2kI432jyIq4uVNjw0N
         EoRo6qCnE4mMLB/jDkIL8/2smzPXH9GMdEq1r4Gg855ARn6zusxchIV6fdy2k6QF+KBi
         /biRAG7q4V1Xg+pWDpxMF6i/rgWW3HsbRRoSGfPJFUwT6J86rS8fIG62wRhePF5XOc3X
         j4Swz/C1J6DW2sm/z7ft9pyCXPhRru4Im7KpqbsoSIAnTSZYdKVtp7Ljnt1zTm/jbBvu
         E2eSHwqV9RohP8q8IIvhjAoe64MIgkpL2Xok++B+fkTguQVDmTT1TTuhsbPSOtC63FEH
         Mk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608447; x=1793213247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=sVIZyjt0eEymlKlMOhFD1whDxyil0vwCu3vJd4yXeWtNC9YTTLIVxmg40JegvsbTTZ
         Mcwu9Pt9w7TaHy1Gg5MTk1PddJB4xKeMN8+osRpqUPkzNmFtNHSFDrRmeVHa4t790KyZ
         IYNh9/dRjtlQlXMbIGuF+qap4FKr65tdAGqGSeRzDKmpP/MzkvtQrirfj9s/xw3abUvh
         jVeX8u7vpip6g9JEfAbjg5RCxl+/66kohO3E7xYMyJ+FOIetpPO4Jxx6M/DdRf9Bg8kL
         nh1FvUqBZZortjYYUXoIae5OtWgxB5N/8xImMb7ziur4cVkP4OJlLn8TchrlkLwIx4Zd
         nkIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEbxZt53NXu3KD2Omj7F1wFA1r4k4LI0EQyFFuJ9XI5Dliwf0yLBP+g5EzAJ/WMKCoxDB/fw==@lists.linux.dev
X-Gm-Message-State: AFq9FYISCv9fIr7wYGKFGVGH1VLs1MGRlyQn4YLmqcsL0BD4vsrv/SOa
	j9IQM/8x9mPoypZ0BHdv963MtzsevpLY82TN6u7YoBc/wxOu6oEdyYrTHpc8/xYTGBItSmJA+JK
	Xi85PL1YkTrlWC/Sj5jtq+Dmx9ZBVLImdNfp9HKAm
X-Gm-Gg: AYBFou3q20APtTmJ0M+0/0Y2SfgrTf2C5qAUkaXmUf0tX8lhXnfHIKElyQerWtegOxK
	juxX+UQjE/QqmQPRUPq7bp9Pc0fsAsmNW6lYAgUuXRApxCVTF1vUanHGyT8q4iqGrmzX4OKCVgq
	+4uJqq7brHuCvZLIlAMOXJSr2VXbxbs4/aNUzD2q/PtnoauMB3pLeF6Ys7SdAZGV6F09wJjH+dH
	xak5ySTqcWH80IP8kvFWYuGjtms41Bav+xQYgepWjKD7dBKf7zpZGL0WfUOinJHdgTYQMhlCe01
	dcL668Jye5H5HxKglOGpo7BIhXz/G0B5r65VIzyC+GcRe5ZkEM/uIVQnH1h1EZxyi8XGC6bDXXe
	lrBBKzXuaFz7Cp76KMKyAxZ2LrNrzI2XUsSJ8nyTWWMm+UxzsrAaQEjZHW28=
X-Received: by 2002:a05:7022:2507:b0:14c:efa5:ee7 with SMTP id
 a92af1059eb24-190a4d18cc9mr4696437c88.14.1792608446024; Wed, 21 Oct 2026
 11:47:26 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <9huzecdi6go0.fsf@tarunix.c.googlers.com>
In-Reply-To: <9huzecdi6go0.fsf@tarunix.c.googlers.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 11:46:56 -0700
X-Gm-Features: AclHuK9GVWu4pH4tc-A36maNXu-EHT2uwChCmCT-hqS2EBFk28gxkLJBLwcVEzg
Message-ID: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, 
	arnd@arndb.de, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> >>
> >> LUO and its file handlers validate handed-over state with monolithic
> >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serializ=
ed
> >> structure, even an optional additive one, must bump the string, which
> >> breaks live update between adjacent kernels. Replace the string in
> >> struct luo_ser with a feature header, so that the target kernel can
> >> accept or reject the source kernel state per feature.
> >>
> >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
>
> NOO, It is not. It is intended to avoid complex mess with unnecessary
> over-engineering.
>
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> If we will have dynamic extension of flags, Think about this.

To support dynamic extensions in a backward compatible way you want
something like this:

struct luo_feature_hdr {
   size
   flags
   extensions  // offset of first luo_feature_extensions (or 0)
}

struct luo_feature_extentions {
    flags
    extensions // offset of next luo_feature_extensions (or 0)
}

And then an example serialization struct would be:

struct foo_ser {
    struct luo_feature_hdr header;
    ... fields ...
    struct luo_feature_extension extensions1;
    ... fields ...
    struct luo_feature_extension extensions2;
}
