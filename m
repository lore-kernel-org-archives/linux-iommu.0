Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C103239;
	Mon, 13 Feb 2023 20:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE5DC4339E;
	Mon, 13 Feb 2023 20:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676321008;
	bh=LhGXEydzhzIGCFr9vFVD0Poi6fXU0TxaqAAdiMVgxh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W3ziS3tTpTUKiAQCvfgSg0WExH/Itc3Dw0NcrOj8GDG9YApZA4JXdU+p83ftOwh0X
	 9O7oSo3NazjU9/MLClmODRPQYoMImpxZACCVajea/NP2kI/BgrepVpwU4dt8IOLFev
	 jSznjH+9mbPKrymxTASoPN123JWaCDFRVvMSECYzDebw7Xd3kPMfhh+TOYd/wnrKd0
	 jtzFjItU3TFfXPVRSvcCuNFZlH6GKteP1MTgUn+ZqHZOHe1jcU6wqu/zAAHHjM7Hmg
	 V3VgBjSmZFNB94Z1WghkNem1hW8AwEoubvYCYlUOU/DAFeF6sEnBE4pV+AJR6kcTHY
	 wmq/PNxRTxV3A==
Date: Mon, 13 Feb 2023 14:43:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in
 has_external pci() #forregzbot
Message-ID: <20230213204326.GA2928938@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201232421.GA1908454@bhelgaas>

On Wed, Feb 01, 2023 at 05:24:21PM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 26, 2022 at 02:29:39PM +0100, Thorsten Leemhuis wrote:
> > [Note: this mail contains only information for Linux kernel regression
> > tracking. Mails like these contain '#forregzbot' in the subject to make
> > then easy to spot and filter out. The author also tried to remove most
> > or all individuals from the list of recipients to spare them the hassle.]
> 
> > #regzbot ^introduced v6.0..v6.1-rc1
> > #regzbot title pci(?)/iommu(?): hang with kernel 6.1
> > #regzbot ignore-activity
> 
> #regzbot dup-of: https://bugzilla.kernel.org/show_bug.cgi?id=216859
> #regzbot introduced: 145eed48de27

#regzbot fix: 04119ab1a49f ("nvidiafb: detect the hardware support before removing console.")
