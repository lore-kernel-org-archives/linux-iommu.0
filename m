Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395613201;
	Wed,  1 Feb 2023 23:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95504C433EF;
	Wed,  1 Feb 2023 23:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675293862;
	bh=GLph+1rJFk0u/NvlB2noU4pttTbui0y47VGL6ZvQFYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P1FFHUG/5as0Abb+4E5DkK1s9JsNhc/ZzdmoYbvPwgJlyfqaUjYkzxn1+R/SQ7RoS
	 ZIyC745UHbT+94/dRlk9aoY9YIijnkOXhYlP5CGtOoyjupKJbGwQTSrD+k/wX4G7Wi
	 qmbFyZeI4g80TgudyS27Fqkoxl999kTFkf0HTvdzz4svdnkELhhmok9uwBxYUMrCYG
	 ni8VgFO78dCd9dBgO9+DLt8NeqTFYOFkhc2DSee8+MXqPAHTRDSRH8D/OPAl6/Ejev
	 lg/czgwmTL3UeMhgMn1/HZA6paJ7CtJxKKkMeBPN8cynza25byZM2ztA4jQc1JjBhK
	 bJ6C3nXJNqW/w==
Date: Wed, 1 Feb 2023 17:24:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in
 has_external pci() #forregzbot
Message-ID: <20230201232421.GA1908454@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eac7a29-fed2-6493-a604-17fcba2a13ba@leemhuis.info>

On Mon, Dec 26, 2022 at 02:29:39PM +0100, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]

> #regzbot ^introduced v6.0..v6.1-rc1
> #regzbot title pci(?)/iommu(?): hang with kernel 6.1
> #regzbot ignore-activity

#regzbot dup-of: https://bugzilla.kernel.org/show_bug.cgi?id=216859
#regzbot introduced: 145eed48de27
