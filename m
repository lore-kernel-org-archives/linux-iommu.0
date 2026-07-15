Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA119F137
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082766; cv=none; b=IJWSmxjz+B6r7Ht0VFqZarEg2LH6WVUWAygSx0nVSiziGXfrtsUEYkTWzOKQ7sreT++Y5QFQ9bjI8o6l0fT2Hf2llsY9Q8AWCEFV3gd/OkyNZenirjttEK87sV4SIWepcSErvsafLfn2I/2QtKVYH4eOoxd/JNVfijT8mYLxmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082766; c=relaxed/simple;
	bh=x4ULZ3SiV08lMK/e9/MJB/fdCc3hV1easrOVlBgzKGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=UKfWG9IIcWa/RmdebjfQGJxcI4PlHEnUGjsk84+BzdeNBw7BT5I5L9FLUVWthl4b+YnsD99DYzPhlVdjJq6zpWWd28yJVKvE48Tv81/dDr2wFolgJO3q6D5ID1gkSLdMGUG2/TGbZH5DfAJwsN9/Tsrda3gCwdweur9plbPA1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lfUmTTBR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lfUmTTBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=x4ULZ3SiV08lMK/e9/MJB/fdCc3hV1easrOVlBgzKGM=; b=l
	fUmTTBR9REVkyZHFCRbO6Pc9xWs7EpP4m4VqbKB/Mz0zoe+Qm6PCarM1AwBdl0bO
	qWSvIFuNOjbBSM9ptNTSwXP/d8Sad5I1yeuIH7Zi+XBH6ICsZx7D/1Q1PTze1J2P
	F9qFK8y/faG3RiLu7px87dvoPBVoCQa7nsljKwNI94=
Received: from 15927021679$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-115 (Coremail) ; Wed, 15 Jul 2026 10:32:25 +0800
 (CST)
Date: Wed, 15 Jul 2026 10:32:25 +0800 (CST)
From: "Xiong Weimin" <15927021679@163.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, baolu.lu@linux.intel.com,
	jean-philippe@linaro.org, xiongweimin <xiongweimin@kylinos.cn>
Subject: Re:Re: [PATCH v2] iommu/virtio: Report faults via
 report_iommu_fault()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260714113626.GI674038@nvidia.com>
References: <20260713010442.331096-1-15927021679@163.com>
 <20260714020251.175824-1-15927021679@163.com>
 <20260714113626.GI674038@nvidia.com>
X-NTES-SC: AL_Qu2TBvyTvU8v4yGeYekckk8Ugeg8Xsewsvgh249ec/0Esgvg4D4seGJsM3f1+tCEMxC8tT+ufDlxw99fcYZkLTM4i6qqCU2J6nMOZ9wDqQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <76298ad5.2065.19f639e4754.Coremail.15927021679@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cygvCgD3n5A58VZqiTweAA--.14197W
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0Rm6Q2pW8TkKkAAA3f
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBKYXNvbiwKCgpTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4KCgpJIGRpZCBub3QgaW50ZW5k
IHRvIGlnbm9yZSB5b3VyIGVhcmxpZXIgTkFDSy4gVGhlIHYyIHdhcyBvbmx5Cm1lYW50IHRvIGFu
c3dlciBCYW9sdSdzIHF1ZXN0aW9uIGFib3V0IHRoZSBmYXVsdC1tZXNzYWdlCmNvbnN1bWVyOyBJ
IHNob3VsZCBub3QgaGF2ZSByZXNlbnQgdGhlIHBhdGNoIGFmdGVyIHlvdXIKb2JqZWN0aW9uLgoK
ClBsZWFzZSBjb25zaWRlciB0aGlzIHBhdGNoIHdpdGhkcmF3biBhcyB3ZWxsLiBJIHdpbGwgbm90
IHNlbmQKZnVydGhlciByZXZpc2lvbnMgdW5sZXNzIHRoZXJlIGlzIGFncmVlbWVudCBvbiBhIGRp
ZmZlcmVudAphcHByb2FjaC4KCgpUaGFua3MsCldlaW1pbgoKCkF0IDIwMjYtMDctMTQgMTk6MzY6
MjYsICJKYXNvbiBHdW50aG9ycGUiIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6Cj5PbiBUdWUsIEp1
bCAxNCwgMjAyNiBhdCAxMDowMjo1MUFNICswODAwLCB3ZWltaW4geGlvbmcgd3JvdGU6Cj4+IEZy
b206IHhpb25nd2VpbWluIDx4aW9uZ3dlaW1pbkBreWxpbm9zLmNuPgo+PiAKPj4gRmF1bHQgZXZl
bnRzIGN1cnJlbnRseSBvbmx5IHByaW50IGEgcmF0ZWxpbWl0ZWQgZXJyb3Igd2l0aCB0aGUgZW5k
cG9pbnQKPj4gSUQuIERyaXZlcnMgdGhhdCByZWdpc3RlcmVkIGEgZG9tYWluIGZhdWx0IGhhbmRs
ZXIgd2l0aAo+PiBpb21tdV9zZXRfZmF1bHRfaGFuZGxlcigpIGNhbm5vdCByZWFjdC4KPgo+SURL
IGdldCBpdCwgeW91IHNhaWQgeW91IHdlcmUgZ29pbmcgdG8gZHJvcCB0aGlzIGFuZCB5b3UgcmVz
ZW50IGl0Pwo+Cj5TdGlsbCBuby4KPgo+SmFzb24K
