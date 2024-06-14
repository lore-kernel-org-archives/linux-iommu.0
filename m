Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A9E1A3BAA
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718397009; cv=none; b=DOK0iqkjd5MO+EwLoplX55pu4/gl6vKr8vQueyR9ccT8sP5uTDsj+XpbdsbOxhuKDFTzyp/uZRr+nfeOLzmXrWk472OK2RCV4qydh06LxSEbGuTcU1qOgMEZvgBwBiTYL+NlHmyNuyAeZNaTKC1QJzDNleXPURONjJm3K+3WKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718397009; c=relaxed/simple;
	bh=oCiYWKj7fKvXvA09gRXC6Z0ywvUJA/RbhazDFE/5KmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNHUvzKlaDFUZV+L0uhWi712wnhg0eM5EOc2GeNAqytgJMSs6TJulYHQg6WHOFOKH2m1zbZgenhNZ+2DAn2xaFOjrQzQFC1fzOSVOMCpq1ahhLgrxKaFv2H0AqPx7036JUgsPcQlx4B8H/+QjGxxoIQkORSGEqnt3QL1Racaq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=gOJl0MaZ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="gOJl0MaZ"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso1235011eaf.0
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1718397007; x=1719001807; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xJhJt3J2nxJAuqKZHd0QwEciJsDRhZULynwju7SQhhA=;
        b=gOJl0MaZEQrdrEJ86nTxNRySiSWBNEWIbIdQ9BnYKcH0m4Por97+iLVfd0wMjPtFro
         9K3L4UeLJMd7d9hbthtsHCTgkkqsEe/1Cw8ou3uW+TZK/m7VOH/BBkEWYHJBM51BVn50
         1UqdPe8ZuQq8ABhwHPGTzUmF7E7PyiX95GNHijoIUMdxJrKbOUFG4JbfQ5asux1Q1DZH
         nfMLWjkGuSdnJmZ6rQa9heXlsSkoxlIWNW/5mDXsMPye7ThwA5U2yNxwfG7lkANzjCXa
         lgnQMBJeNKhkdwPcyFE21S5Y2qCcvcyD3yjmrS1OmS15iv23a1KmZnpipnbEXsy4UiKb
         hHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718397007; x=1719001807;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJhJt3J2nxJAuqKZHd0QwEciJsDRhZULynwju7SQhhA=;
        b=d49s/q0l2+3fuAlta/XJ4DmCu2toZpiBVwBjb4ETt+97Vv3GZ2fTgb2KveuH+MWyvu
         ihWLVCCE4lowoxQfvnUi62fI3Uc2+29SVZlfd0ywmIw02fEeVfNmeKJCCzKrtdATRxig
         maOBa5OJgXgxuKRaDtWUzs31L229XPAcfZGYRtJwKhwMnpbR5yfBKgUaIJ6OXKUrg95m
         b1dHFl7wD7vPvkRMMj00AutVY4P03LSY5xDXtUSmMMCVRFcoPeCXagKR2ERyDTZxeQC3
         w1NwaUCGsV8Se73+Bz7+ceo6DU77cDOx2KkSRpB12wye1/HGslxtzAwikNJMqvT2jRP6
         XfdQ==
X-Gm-Message-State: AOJu0YwRZT0vMghKlMPcMdsUaJ7VA2bHxT0i6kMk78eLADxp9pway7Ze
	4zCl7oMQPXynh4fe3dwrXOahDsXamRT8tcDBodolIP9mUk8KuPikfXgwAb2NytI=
X-Google-Smtp-Source: AGHT+IF4C0ydFkr3IsNAr6Blq5SSboC1En/cdpILPHYan7A2ZMTQYSAcMnFNnwq4qkuN3PHcllTO7w==
X-Received: by 2002:a05:6358:9103:b0:19f:5317:49a1 with SMTP id e5c5f4694b2df-19fb51658f7mr465229255d.28.1718397007051;
        Fri, 14 Jun 2024 13:30:07 -0700 (PDT)
Received: from nicolas-tpx395.mtl.collabora.ca (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5efc23asm22245446d6.126.2024.06.14.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 13:30:06 -0700 (PDT)
Message-ID: <0faecb255d7e1e67153321d9009f9fc8c0810cd7.camel@ndufresne.ca>
Subject: Re: [PATCH 6/9] accel/rocket: Add a new driver for Rockchip's NPU
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>,  Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner
 <heiko@sntech.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Oded Gabbay
 <ogabbay@kernel.org>, Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Philipp
 Zabel <p.zabel@pengutronix.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Date: Fri, 14 Jun 2024 16:30:04 -0400
In-Reply-To: <8f93c724-3c86-c0f4-3a84-8a72817e684c@quicinc.com>
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
	 <20240612-6-10-rocket-v1-6-060e48eea250@tomeuvizoso.net>
	 <8f93c724-3c86-c0f4-3a84-8a72817e684c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

Le vendredi 14 juin 2024 =C3=A0 10:16 -0600, Jeffrey Hugo a =C3=A9crit=C2=
=A0:
> > +	version =3D rocket_read(core, REG_PC_VERSION) + (rocket_read(core, RE=
G_PC_VERSION_NUM) & 0xffff);
> > +	dev_info(rdev->dev, "Rockchip NPU core %d version: %d\n", core->index=
, version);
>=20
> A properly working driver should be silent by default.

This is not universally accepted statement. Most drivers do have a one line
"probed/detected" kind of report.

Nicolas
