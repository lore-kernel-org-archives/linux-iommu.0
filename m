Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DAC3A71A8
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207981; cv=none; b=epx4KVztH40NIJ9hlOtdqHqhIdlChbeeNpahcOQhJ2IbTOEsqfVJ/VjgW6x5cDrHOiFme31ikY28CC+0OqrxBVDjm63YxLJXNIet1gn4g3kpAu+rFiQef6UCfqRSYXQQTp+J75MNujwiRCUHYzq7BddOj23Val6mu0zdNPfpu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207981; c=relaxed/simple;
	bh=rl20KffuHLifSjIai9JG53BDGfyJQlK0QAVe68gOQsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMFFNMbshbgZgdCYo6CieJQ4NjrFq6dpOsxQH2yQ6T/S7Zi630A72CLaWIBLPNqSOJ/avaZYbSJDqVLJffRxC5ODKpTcFUyAf3H1E6eA6VHvEMeCPiuESHbfU+c6Z7kLx4wwnkH+K7vySFDzMkbCs4DaGYy9RHQdlnXz1yA6z7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jstarks.net; spf=pass smtp.mailfrom=jstarks.net; dkim=pass (2048-bit key) header.d=jstarks.net header.i=@jstarks.net header.b=GNLeXu+9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XTulnCOc; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jstarks.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jstarks.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jstarks.net header.i=@jstarks.net header.b="GNLeXu+9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTulnCOc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 404051300DA2;
	Wed, 23 Sep 2026 19:59:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 23 Sep 2026 19:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jstarks.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790207977; x=1790211577; bh=L7EGaKcamO
	r9RV8xqP5Tu6hwqK+HFnYJrG6zbzRy8eE=; b=GNLeXu+9gckaXobbnJ1MuaQdpN
	yToxvI8fvhV+of5bGe+Z9OJnYJ/yNtRM/UEfl7cvpVX4Pb6axB+tiH81/UQVD7yz
	hcTj6nX1vFjwEr9HodOJYJDJPqCCieBrynQPco3YOhJBZ+q/hs8SkX2PCy1vaHjO
	e1e2TGRBQTsuH211/eqLNaUJ5IR5oFeJoiBKDMPrGm5OnSyDMe1ZQPO9ImLhMbL7
	Pq7A6vbNKTO8cbyp2szeyka11yXNYBjN/l7iN1IiNVmpx2iJyPDsFcXmlRDNFR8N
	b2C66Y0jy2SAEw753QTZvg6As4/LTNRTFM7KOPElHBtW3+/uIgWvjXQts5fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790207977; x=1790211577; bh=L7EGaKcamOr9RV8xqP5Tu6hwqK+HFnYJrG6
	zbzRy8eE=; b=XTulnCOcy0W16/SIq+lM9IkDZS9QMgOLH9DJHCAB0HRdiMqIB1l
	h3I5XjmmyEY+o+Dpa8/deD2Dmqp0u8RwhvHuxLiLtt+YbYJgZ1UFfMMoeMANjNGJ
	hUxPYSFsgwk2LlPoIf44Dx0uA7guyPAIDywce52YsGtNwaBqPDRYOCx0YAAcPICI
	t76xZpK2iM1zD4uX4fAe9FxubgFAQyHNZVl8K6l7KreyE/dvkNQApK2STcv6lh76
	J7JfjnEAuQ8yEqFIgQ+8OVCHH6XzPCP3l/DeLTwN4QN2GbIK2xZP8cyxwH5C30dG
	Gp0dbgyBOdlB1SlFN0vwLiI8AOPW20Fo5SQ==
X-ME-Sender: <xms:52e0auRbxO9TapK-HtYTGgaSgsM6QsmopCU9vV_6qdaoe87yKmRFEw>
    <xme:52e0akKsaLkFOYRVxgBQ_aZDxGn48qDo7UnGCTISHJkhe2nYsPftQ2CRC-y_wlveH
    336Oio09_vMztuHJnpANv2UlQckHoKmIudIWxfwKCpd2l1W5Ipk-6vs>
X-ME-Received: <xmr:52e0as-x5oMPrkO8mY3cUJ8qZvzXb1tMPAU_wArF5oN_AsSXGoeSIygFEueDgDYQgujPshlvd6t44wu6>
X-ME-Proxy-Cause: dmFkZTEEr3Zo+wTIMlmxZhOOcWTw8Q6j9fKqM8F3viAtF0lOzGgBq3kaB7VempZURbAQG7
    MM85Yo7oMlnff07MPTErnMoR2UoyHrLJ8HVMg9MmlCfSKU7R1im+CJpNDEMpbUUA2gzwZ7
    lI0A2TXMi5s9H4YwjY21TYhD1ccE+lEahALH0F7eoFJQa0xRLMXhEPBO30qVVg9w4uNNZG
    mAv3EiwLVBDxPdkUh694RwsUZMpuzMZSbUiOXgEiDZNmGyTo+DdwZaZudeIk7qYQx0Fmbp
    E+eNBt0+Xbv+6zq5oTGmDS57CfyzGCdRTbySOJYuQTuipLeKL/v1yQdPFW3R9GLwo4RqLF
    KXGaj2+ISHudSFLVWXCWLdok9Oi6wk178cptL0siXGEPeDHzJuf1inVFfNXoYAZVQFP3u4
    NEJ5XMbdlH0K5asmZOAKCx3/tar5E27OVjXUgL25GCKuPj51A8Q9mW1/ze330K0620uTli
    agrStgkSAH+tk8G2auY1YzkCiN3vmktjeZnC7PDx+RP1phnXegyHAzrebeJT+9DqyeAcjU
    hVrFVwGx4grHR9kgYXyo54iJ/1n5QC3gt1s34/KTcQgcF2OHmn99HX7ycGCELV82W3QGEI
    DjzRMLmT2Hcv797xdgQ2vwnD0Ciuyk4aXW7K6KMsV4KvF1nMK4WfIim75rDA
X-ME-Proxy: <xmx:52e0amBgn3fTE4a3d2dniaf2lzcghPVmTO50CGyzVaTPcWYLGvwfIg>
    <xmx:52e0ampNIdNKH9wJO4SD4R7Y8VkPzh9KU8qD416QnOeQFZus-NVIYA>
    <xmx:52e0avLZLsWeLc8j6c-GTCLyZ9YGKty3TsWeiz3kbdrsY7uj5Cm2jA>
    <xmx:52e0aoLV_xm7tfSlHWl9Zx__hw1wzYwM-RPq1W4J2mH5OdkS8ARrBQ>
    <xmx:6Ge0alMmmVoIT8tcE9fkK1fbTcxiTxy0w8H8UoGyaaZPh5fOCSSn87Nz>
Feedback-ID: i1b3e4abd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 19:59:32 -0400 (EDT)
Date: Wed, 23 Sep 2026 16:59:30 -0700
From: John Starks <dev@jstarks.net>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, John Starks <jostarks@microsoft.com>
Subject: Re: [PATCH v5 15/18] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <goxdwq6ny332pnrojvp4nuz2mliofd3yxd73fpjnbesq3e34fe@jq4d7v7rbwx3>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-16-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921004834.2601285-16-skhawaja@google.com>

On Mon, Sep 21, 2026 at 12:48:31AM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> +
> +		/*
> +		 * When this memory file was mapped it should be sealed and seal
> +		 * should be sealed. This means that since mapping was done the
> +		 * memory file was not grown or shrink and the pages being used
> +		 * until now remain pinned and preserved.
> +		 */
> +		if ((pages->seals & req_seals) != req_seals) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +

Is this sealing business sufficient? Even with the specified
seals, user mode can still punch a hole in the memfd after it
has been mapped. This will disassociate those pages from the memfd
but leave them referenced by the HWPT.

Then, when the memfd gets preserved, the hole will be filled
by a new set of pages, and only those pages that will be
preserved across the kexec. The original set, unless I'm missing
something, will be dangling in the HWPT, allowing attached
devices to DMA to the wrong memory.
