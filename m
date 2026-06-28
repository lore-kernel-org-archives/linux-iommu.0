Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8751D88B4
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782642706; cv=pass; b=kuSLceTp+eXAkaB/2NioeY/0ecXLo22jwmGCzrqdqC/V1ZLFQh7tIa3W4p7r+p9xRqrrzSJwqMuvzLK21oz9RQODXes+NdsqK/RG9dWzLPKlgkV9QrujXFG4InYc2lzc5MAYUp/zIMWS4kjCCQ0sIao7E7IJTsWY3b/qXTDEfrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782642706; c=relaxed/simple;
	bh=p9T7gPyArMS/KVn5vgGJ/6O04XuwG8iFCNcQCBiuYx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7r6lZPUTnNuO+7rw5VgVrFl/YndtZIPISGLc6eSZlvAJREL074oUrXFbcL/zvBUvDCsUMlm1X0TyuQg+H7BFoNl8GXee0itPscov3i1XLeCyXKOmhU7Q/kKvrjYYpcSlaXUTGco7AZ4SkUc/JCiDADCeVlT9Drq2qsexZRXEVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XImHuX1G; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XImHuX1G"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30caa24aeb4so149250eec.1
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 03:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782642704; cv=none;
        d=google.com; s=arc-20260327;
        b=M97YTeNFE/WB5E6tUqQFlMB3BygmNA8SVXON4TvjnevyIvmhnc/aUYnEyBR04Qx3cs
         poCVv5iIWSQqDGIzAA8kRJ+LhpA4WVA8GF6aGhb4ZMSBHJqREy29PA4fgFGmsYw2rgH5
         pNZNS6xuOcoJ/WcGHlfumdx16HNRXztQUx1dtbohMs6MZ9XRMJ0xCEmPePZw6hjIgbkx
         UFndNHOHnI2X04TBwlUVj3EcSGfHfN1/rA+5m+2aLTMe58YxM2GvjxxeNbheknicAgvS
         ip503VVQ6aOBH4Xy/0XH4+m48Wl1ZaWwjDcR7ePQklNMsNKZwvtjt82Ap0c/7Kt90gsB
         6iHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p9T7gPyArMS/KVn5vgGJ/6O04XuwG8iFCNcQCBiuYx4=;
        fh=+Uq/ttRiAC95j+/SZtmKiocrzy15joHlH8xdMFD2ay4=;
        b=AEJCTZFczZISMmwfdXwJzjhsH/P0fMop4hzox3uUVgjEq7r/hbwDciiZdjKd9TPKm+
         dgMyKqf0qXokTwdPeW9GEPBEK9lswTpitDDeX4RFUJYZi+tgeN4yt3N7tl6l/QDVzSpD
         Y/nfsL1e2d6cDIMkONqm2hwrQmzhSc9G0+nSKDWqXcf3uMfiTJ+EWjXOcOzRSwdCBhd+
         6mLqe11a4VRo92JuqBE5CSXSgqi9tUky7F1eq0sUzHwS0kxX00aTOCzKkuadjx1tqPhd
         2D2Ff00MjVe5A2zvduFpW9QSilQpFXRmquSPSCHlCdHFI+vXOijncxAeZ1dzXD2+KDIz
         UNfw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782642704; x=1783247504; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p9T7gPyArMS/KVn5vgGJ/6O04XuwG8iFCNcQCBiuYx4=;
        b=XImHuX1G6eROIok1u7J+vgm2WZ53YfuiJSht2tGm4+AkbxKeGhRPAF9d981do9Q2Dy
         i/INKaN8zsdO5sXHXMvN2NEvMlnnoIvQZP4xANcs2tpmxLaht5yUGJbqhGSVeaN/1f+f
         06GXOF7alyzr7zXPtD3NeApakaE3J+qG7G/X8sz9riF9At1unUaux6rwbsEKSV5cu0BO
         v1DJwQxDIwhDWBKYJBSILrR60J4PiOAVzdn4CmuuDsE204jL063NPRFa//5dgrCrej+m
         2l+of9Tf/HPTYgyHDitVtyK/kirZjeExYx+upJl458HpD4R5axMJ1OKE8Ba1VT7xuPfr
         Q/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782642704; x=1783247504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9T7gPyArMS/KVn5vgGJ/6O04XuwG8iFCNcQCBiuYx4=;
        b=DZnkUEgJm3NzYyiXBiGnRmXnICm8E/Fcpk0FOBZHr9jXmvcKcXHFIemU+M59WBAhU6
         NP1LlwX5H76zkaK5LDJYrjzjXXpaJWB2thaJhjmgihzKl0LyZmf6sL1SlSNNoZ6c7o6C
         B9TddxKtG9E+TLhzhGtDdZ9YefwkeI7D5ogXass/jnnaamW0OQmr9gzGobXez7oaLsI9
         Qtzfjrh6esrn0/cF8+l/Zp1x/a6Cek57zfrJFpHixODZZB9bnzvmuKFs/XrI0oYz0F3V
         8e2j/jIBRTg7VADmMROH21qweHNmRb9YLoCUmMGJsKf/ArFcfVXYZLQ3AC1Y27vur/Jf
         QSiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUNZiOiA5ooao6rnMPk5Pg7GAlSl1MoZdPKS9YedW3ge4os4svJ+2hSyc9zaiis0S863FuAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YydvcLYevAQvbvCoM094jD6FWB18TwVs23cI/NPKFLOMacw/ZF9
	dmtUvXIN6uhhaHqWiheckNmU8yw7WuMIUycRe9yxUJVkEhKP4LrhOCfqcZeBeZk94xXZJJwuz9x
	9t+6U074G0re36DTD2zZ0KmMnsRqB4jA=
X-Gm-Gg: AfdE7cnapF23D33DTJ46KQ5ngT6hBNe7wXCOe4V359qjc1YmtEllzPoaCWA1nLLL6At
	K2PX202Q7lsLjo3phyZkeDD4uEFoiC8xUrEmSrfrPRCNCJsl3GGBG11n2J+uxhDLQObRzcjlI8S
	XrIzYl+r+lXhQy7SPnEciWx44lG+Tpvdr2tYPN3+Ze3bXqclOIfu+Qw9WhjOrluPjsHidWeL0H5
	hBf5ScKJdMQm7rGKR0/9ll5AzNoak33GK0Ju1dwoqwjwBdBJRP1d0ZOhfE84xnobEOuJ/0PT03M
	LWRKl3wzz0JkTF95i70/7bH/PTyHYx1uK2g34mR8cJ1UFnAKT+EkT4A0slJPbSp+QnGW3nX7cuf
	ml0T+u4YchSbS
X-Received: by 2002:a05:7300:d517:b0:30b:6192:5b9 with SMTP id
 5a478bee46e88-30c84def54emr5929447eec.8.1782642703979; Sun, 28 Jun 2026
 03:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260626203122.713317-1-nico.antinori.7@gmail.com> <DJJOZNFW51LZ.IKTXQ8ZIVO55@nvidia.com>
In-Reply-To: <DJJOZNFW51LZ.IKTXQ8ZIVO55@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 28 Jun 2026 12:31:31 +0200
X-Gm-Features: AVVi8Cfa2gu-uh51v2W-N-eZdtsPgwAWc2f3g7iiuHZxmyLE0nd_b1sk7GagU0s
Message-ID: <CANiq72kdCAyRUmXFcqQfkHpk1miG8Gagsn0_5U8p4WpKxv9d_g@mail.gmail.com>
Subject: Re: [PATCH] rust: iommu: replace core::mem::zeroed with pin_init::zeroed
To: Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>, Gary Guo <gary@kernel.org>
Cc: =?UTF-8?Q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Tamir Duberstein <tamird@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 10:35=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> Note that you can also use `..Zeroable::zeroed()` here since we are not
> in const context. Not sure which one we prefer in this case, but I'd
> personally err on the side of not referring to `pin_init` unless we are
> dealing with a pinned object or need to because of a const requirement.

That sounds reasonable -- Benno/Gary, any comments?

By the way, speaking of that: the docs of `zeroed()` (both of them)
could mention the existence of the other (and the `const fn`
difference).

I guess this will eventually go through IOMMU, but I can also take it
via `rust-next` if needed.

Thanks!

Cheers,
Miguel
