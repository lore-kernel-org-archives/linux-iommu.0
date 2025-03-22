Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F879FE
	for <iommu@lists.linux.dev>; Sat, 22 Mar 2025 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742684340; cv=pass; b=UEmghAgfEL3hAc570yOXTX1O+cd7u9Y40ySXvaYY6A18WIvffgDBtQbw/P4vHdQcRkLO6OVKH/Q/QUH6KakbYKmh2VWl7S3X3Ev0eGUQwXMEroEuYe2vE65RnVtT9k4iX8WTwFfkEGNQJBUVJC453ig1BkRWu1kjFtRqponbTNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742684340; c=relaxed/simple;
	bh=XGMy3jFc28cA7rlCTbGV1UPJPidx244D4ob7iNMHZbM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YqiVH0VKZc/y4QrRH90DH+lqIy+OV6ZOfiAF4BmZ0vapVg7ANbsuE/gix0G/kKpb6/sjqBAgFIZauNNh9wWiBw061B7nUGqK4yPmlAq6zYfPBJzYv2gzAXIUviGFi7m5qpR6DxklncBp27quSmbq3X2ons+Ihg86ff1LBXzBOCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HtFHuJ/y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HtFHuJ/y"
ARC-Seal: i=1; a=rsa-sha256; t=1742684321; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FGSgKYahcumdct7tO4Kou17nnccLE7Q4MyHMCJ0YrcvILiz/cdIhXOhGTH4gXtHlQpeCSN7R8SK+LDfGLYAjOQMy6J5ONoeZJxGl/MWu9k/q8p87amJEvMeRqJxpoR4kvaBdyLVd++qVRbIX/UF2OSVrLMcd/whedDROcshRf50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742684321; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XGMy3jFc28cA7rlCTbGV1UPJPidx244D4ob7iNMHZbM=; 
	b=N8Du4+oTWX6MdWwvuRbxFsixJzNgk3xwICKtfjXcnzalat6NKhPwRow9Is/oca2ho3zvk+iaC1/WucIclHMYZVdzT4vwDYJBQlCcdMlhj+4Ao09JwQTIt0YZYbXv6UvdAVENy/FbV0b3IFtWyiPVPL75Lds97zFIczkfwlzh/kM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742684321;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=XGMy3jFc28cA7rlCTbGV1UPJPidx244D4ob7iNMHZbM=;
	b=HtFHuJ/ygUT1MMWsqK4fbndOIlinZvqptI7rOSjJqXZPMTyC0pPEff3eOq/CyNxG
	I6GFI+tRAfs3qjCzIkuiOBypwznzQpxTijK7p0RtvimVpUdkthup9+WRz1glHo5xlm/
	rcKElWYxGmpqyyJ6kU12HYtg42WRNYiXpfQMXfsE=
Received: by mx.zohomail.com with SMTPS id 174268432081031.2758976306327;
	Sat, 22 Mar 2025 15:58:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v15 02/11] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <87senajxlv.fsf@kernel.org>
Date: Sat, 22 Mar 2025 19:58:24 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org,
 dakr@kernel.org,
 robin.murphy@arm.com,
 aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 iommu@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A60CB2E-E6C2-44C9-85DD-914638CA77BC@collabora.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
 <UiefwZ9WcVV7q7YyERsbNIYqOxTWUWEO9aZNxThH7uRFkjE4LDSUtaVdiLeShk_JYe5RJLD5MgFC9IxGUuzTEw==@protonmail.internalid>
 <20250317185345.2608976-3-abdiel.janulgue@gmail.com>
 <87senajxlv.fsf@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Andreas,

>=20
> I think consistent and coherent are used interchangeably in the =
kernel.
> If so, can we settle on just one of the terms in the rust code?
>=20

I=E2=80=99d say let=E2=80=99s keep the `coherent` nomenclature. It =
immediately shows that dma_alloc_coherent() is being used.


=E2=80=94 Daniel=
