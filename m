Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C5A37CD34
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503434; cv=pass; b=rKKxZl00F9mds46VkzJejjLn6sjGJjFd0ZY8v9Dk4eQwsoTAcEDyxnabDqFiAY3fBUtcePElpU81VgGuv75r9+IIok8j1jztoVunuJ1zABeUcxQMeaRmQtbyJAd9aFH9H2rS2zxOaWs+zxnH2nZVj+7/F1VfPJ1WYiVTaB3P2kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503434; c=relaxed/simple;
	bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9yQ5BBmtTMgcLz1Mfms3q5GgaO2FsVY/CI6hK6/T3bryd4zVm3J7740L+gnJDKSl82j/o3GhJANunpzFxPjDVwNfEK7iochib4mrnZlF2g3iDXI76LqU+2qHK6erO5LOUw+wyP6KiLftxTUHo0N+aURglBgb5HoyxRsnAyb4/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0GPGjlQ; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0GPGjlQ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38dd9f0fdc6so16111821fa.0
        for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 15:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777503431; cv=none;
        d=google.com; s=arc-20240605;
        b=BocLxK7byBY81qT7lxkki7p/2IiMc2JHUafdemVIiJHmAm+2zAsruxmqn5O/AxRzQv
         8WXe7GGTtbJIUhOpQB6g5IRaKAQQIJDxL5KnBz2spU5WgIrwFLjM8ijveRkqRbuiX/rh
         ojB4NTJ0Jq53rMsm18qUGzNb1mfZkgTnQCPv6UBM0vp5f8K2OlNhYZPvxOcLBCN1zGCz
         S2ICkrdeK+yI8GsSke3TfJDiqAt4NkBY+D34EUlwMBnf3CJqcpVO2ciVYmb1+KlnHAcU
         kyzXmhgDSZn6r2GwMDoOsarAkSMPBmqAkTUopOhZMaHA4oJfgB7/udNolvq3dxrkoK1z
         pjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        fh=zE72JYYHfHvIr+K0Cow/capIv5Dymc9dqiI/QeMgCDE=;
        b=Q9UaZbXuiGXwu1IP+8+X00WzpOq8sxIdvRVz7cBRwBc7uF1tpQ4U07dBCH6ajkxuf7
         U6kHcIxW1RehQM/+mVe/KFGe8LsKVE/olg5w2YAV8mrCMBZUJZKYICXWzLQxVjt0M+Ho
         VVobP9T6+lNuEFC9OY8J8yileAMEwH30fnV2nucsICXqgVlMmmko0OQIYptKOkP6ZMw2
         ONhOQvK0wZSKvdIhuK3aESSf5mABTGOX2VpgiTksX2EbliOq+WiLOhlc9U7z7NuxUCQG
         SfN97qPLc8062ZA5nSxRVE0djVXyGatrSABswWLLZQ3GzuTb3yk9hk3Q94l3rjz+YCms
         hiWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777503431; x=1778108231; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        b=t0GPGjlQ6hkk2IQcTi8NKHEQZiFlQVgVOmGKynzJhFdksRfZZvdJzvov2+HZBcYKiX
         I1cu4fKRXPS7ombsu4qXZOOCgvIPwxlekQXtEWoBciZ+jCnxB5MzxGzo/xfXEdDq1o9l
         pqywLSlcBSBjb5mXsrSNCWFUaBkf1Bbcl8jguQ5ceZo4Dy8R5QdlUZ5s6tGy8baYaKw/
         X4MpJpRRv1KvW5wTuxqoIGx9/XvpjLQYmYMETtnW4pl10APXHbHr9wX3xg2HDrwS2NX9
         Q2lylMaKX0lpxDL5COq+8iIdqGWmYxIeVzAzgji5KQJZf0Y+TK0Rj3VaaqFjTn4XOkIi
         Agog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777503431; x=1778108231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5PgOh4MKm9Ysku8H251/i15pXVhU7vwYYgGQfsH0l+s=;
        b=Z4iys8WmSrGHCUielf+PcP/HIRdFNnwQNFyKOpkjVldEFR5Lm7BtTgD0lDEFeuJ1iY
         GrYNGWDMNI8zJdH/WjCbsk7nv26ezX6lo8GPhkBZ1R56Tcy5+pvXxWx9I3CT3/I+Ln43
         FF5jKB1QC5tW6uhXXgXVwZ+A/OqLjRYNVedi+tluvGB6ydKBYwxXu7qZjDtfpcvPsAu8
         4SKaEbjQUg4OVgl2HqP6/URxFPzrhHo/VshI/KJvz40mUVatj/bMrpoUUShlzXxUnEyA
         PK51wra5dGseLN3NQAHH/7L6jsz10sKzZIkmRz8KSWCld/ICkxrxTZMFoszlWKdF0TzE
         fgYg==
X-Gm-Message-State: AOJu0YzHAVTRqKw4T2OBmKJlUJUuqfxrWQu+p0snpGizI8y/XX/PBOsR
	TviwDpbX6Uad33DzSWn7rJyGXFS2PfBGXvcZyNoTtr9eHsZfpShNMma7lo6QmBpEsbTJRwvhflS
	XpMUV/tGcGUB/w04XuhFWjxF0SRDnYgyvPoFj07Mr
X-Gm-Gg: AeBDievfs0rL4/yZxHKP0bqNByesghL88QsCo9StQ3Pt7S4AV2x2WDqvc7RfP0G981+
	t19Ypra9W496kRz2jtfihojupL6kYHDRD24+4vaYTrw6Ul7T7lnxqtlGiOFpFR5U+2nk4LB029i
	/Snvc4+ZvrlQOT86g+hNGIbegu/MxTg5iwtr6IdVBimkhDwEFLy/FzXat//XkLK7vKYmWzDyFAV
	ezIMsL6/SSIiEDxXDxBfixpOrLMUnm14C0U5uLtTrxdt6OP///tkyFxeckziKztgujsefE+SymT
	KastQDpV1S0B0ii2rz2styLAcqBRyQ==
X-Received: by 2002:a05:6512:1148:b0:5a7:4912:1a50 with SMTP id
 2adb3069b0e04-5a852741d7amr22979e87.20.1777503430946; Wed, 29 Apr 2026
 15:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-6-dmatlack@google.com>
 <20260427114745.00000656@linux.microsoft.com> <ae_J2pRWFf5qjZXb@google.com>
 <ae_SHCjNGrEPurzH@google.com> <20260429152814.000005f7@linux.microsoft.com>
In-Reply-To: <20260429152814.000005f7@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 29 Apr 2026 15:56:43 -0700
X-Gm-Features: AVHnY4Le9iheFK_YlZgcrAybDAS1kEhRs6kG_ymy3g2e8lI5OrgvcncvoFuHHPU
Message-ID: <CALzav=djG6T_NfwDD+aoobMfqdCkG0Xo8hHU2YkPc20uJdb-qw@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during Live Update
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:28=E2=80=AFPM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:

> Below looks correct to me, but I have another question. How do you
> stablize PCI BARs? PCI BDF stability does not guarantee BARs don't get
> moved, right?

That's right, this series does not guarantee that BARs do not get
moved or sized. For P2P use-cases, we do need BARs to remain
stable and avoid sizing during enumeration. We also need to
ensure bridge windows are preserved.

My plan is to send another series to ready the PCI core for P2P
use-cases, sometime after this one.
