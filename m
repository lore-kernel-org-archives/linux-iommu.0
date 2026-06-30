Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974653ED134;
	Tue, 30 Jun 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818009; cv=none; b=ORVPu0bIloR5jfDQyFKXKQTnHXYrL8YBV7YjjOss++k6DbWB6vo5yucVlROv24zQ38tjUmjB8Q8TRsz4JBtRw7CsaADHugGHhtJQLoU6denfa9PASgo/gjpIzBC0moY+tqd4q7tsY5KNFvWkPfhBtZ3+hcqJ88BwuUH7wTDTvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818009; c=relaxed/simple;
	bh=uZBoD4hToNo2KabJQHYXYg+k7RrwRGIWXBXHh5Zu+Ew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VnNOWAcHvf4IoW8B3sIQ88c0kjuPePZxPkUinvQ7hYiPnvm/LApyKihrYyyl1zy/1i4zVDyuYa8QjZJO90UcF73eU02geAac1egAhswqCni841WLBge9CQsz5xcYsFMvLSDTOj/m5oYLG1Vo5gTk1kW7RjvJN+YvvUuYgsjGImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blytqQRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blytqQRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B41F000E9;
	Tue, 30 Jun 2026 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818008;
	bh=gBrw4h6G+CAidiPHKiZfKf7oBnSSJvuEXV9bJiShaTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=blytqQRac+g9IOLHTev0RLz7JAEA05ZsCRJ4cXitfvYsRAWj+gBUwA3e6cQe8G0UO
	 PmqqWpzCpst3E2PvtVSn5zI6mrdwPf0p93zgNTlUC+ctCybXfH6X9J1JZ3viG6eATk
	 W/0sowhyccmzR/ELJy79DfC7PRH4Hk+2ksfFhFf5w/3BxLpG7rq4fDlGIsoMndRLaQ
	 ISDk9zW3XOoIF3nWXA39CBFku69yw+kff9k6bT2J8SgKMr6GCcewIkNUHIf7kcfpLR
	 dR7FNbthATEO2DTOT+eXGFIJt028JX+fkSP8YDOCwgjuuzeV6rGd5vO1VRkidBO596
	 f9DESVmWQK+TQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org,  kernel@xen0n.name,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  robh@kernel.org,
  saravanak@kernel.org,  bhe@redhat.com,  rppt@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  loongarch@lists.linux.dev,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  kexec@lists.infradead.org,
  iommu@lists.linux.dev,  zhaomeijing@lixiang.com,
  catalin.marinas@arm.com,  will@kernel.org,  alex@ghiti.fr,
  akpm@linux-foundation.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  ruirui.yang@linux.dev,  m.szyprowski@samsung.com,
  robin.murphy@arm.com
Subject: Re: [PATCH v4 10/10] loongarch: kdump: exclude non-dumpable
 reserved memory regions from vmcore
In-Reply-To: <20260630074715.4126796-11-chenwandun1@gmail.com> (Wandun Chen's
	message of "Tue, 30 Jun 2026 15:47:14 +0800")
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
	<20260630074715.4126796-11-chenwandun1@gmail.com>
Date: Tue, 30 Jun 2026 13:13:22 +0200
Message-ID: <2vxza4sci8ml.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 30 2026, Wandun Chen wrote:

> From: Wandun Chen <chenwandun@lixiang.com>
>
> Apply the same non-dumpable reserved memory filtering to LoongArch
> kdump as was done for arm64. Use of_reserved_mem_kdump_exclude() to
> drop flagged regions from the elfcorehdr PT_LOAD segments, and
> of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
