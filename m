Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED0281341;
	Thu,  4 Dec 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764880978; cv=none; b=oDmOsYNQ8KmTp3/rtkp+V0r4ea0G1bmaXqkA3VXPoEqJqZip6Z60ddiPThwdPxM4vujjpsYfV9nXroGkHjajNZSUUBoTiqUKSfVF8P+VkcjtT0SCCwDMVN54TQCyANTTmMbiIYtlNcDqRMJA6XmPWCQLf4TfvYsU/2tEGggfgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764880978; c=relaxed/simple;
	bh=L7d1qiM8xYz9QN18vNQm2ZFkGv4gdjDPj0W/v44zrYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQquy2/FBnhaOLpe/2A6IlEEbJ5YXT5VT8gCn5sr2K9qZRDZ5J5gxJBVJFBKuqNtpRIswBxLDk6tkg5xsqZRnMmgFEqIl1kq8RKVERN0sOI3oJoRDSNksRDwXIsV8yhkDk0anuJIKHREAlj0AUuCnnH/koXfyQyegph7I8V4fIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E49xcUFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E49xcUFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AF0C4CEFB;
	Thu,  4 Dec 2025 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764880977;
	bh=L7d1qiM8xYz9QN18vNQm2ZFkGv4gdjDPj0W/v44zrYc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=E49xcUFrUYpc6YCgzn86tmUuUfbaibTxEmI2IJLx73nGpi4hj3uihtwNwev1fDz5l
	 TYRl5dhm9c4SzPPNeNxeIROryGXc7mO88PPpto7MEwPNkZk5Ap9SIKgqxJXDoymj7m
	 8f2uX+S1hxDVEEEQ2oYgSYb0jxUIXlhngOGwgPDGJt+rbYOUYnks3dx/Udm/Ta0FjM
	 Y/9qh9nv+mQj78jde6qpu+ICfznOJLcvdfyV0w/+BMvdDWmRjMrh14xk18aU7C7c7B
	 4n4z1JwpOPmqBaz/9dHKJihqfPNdEzudEm+KutRk9gGT6ZJHcVyzNshg0R1siuvxbT
	 EdT1TyIS3nUFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4B616CE0E8C; Thu,  4 Dec 2025 12:42:52 -0800 (PST)
Date: Thu, 4 Dec 2025 12:42:52 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <d90a3959-eacd-495e-99cd-836d07955912@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
 <20251126152637.GDaSccLZVBEOs20n6T@fat_crate.local>
 <17147c98-9f0d-45d0-9593-3ede27ba6135@paulmck-laptop>
 <20251203124422.GBaTAwpmOzChS2MDhX@fat_crate.local>
 <cb2785d6-ee19-4277-9906-d287341c7698@paulmck-laptop>
 <20251204144505.GCaTGecavu-E56OR8V@fat_crate.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204144505.GCaTGecavu-E56OR8V@fat_crate.local>

On Thu, Dec 04, 2025 at 03:45:05PM +0100, Borislav Petkov wrote:
> On Wed, Dec 03, 2025 at 09:16:37AM -0800, Paul E. McKenney wrote:
> > Or to some value that works for you.  But if you are not looking to be
> > an expedited RCU CPU stall-warning pioneer, yes, setting it to zero is
> > a good approach.
> > 
> > If you would like to be a more sane pioneer, setting it to (say) 11000
> > (or 11 seconds) could be appropriate.  But what fun is sanity?  ;-)
> 
> Oh, I have a lot of excitement even without RCU experiments. :-P

;-) ;-) ;-)

> But if you need me to try things, lemme know.
> 
> For now I've simply reset the values as to what defconfig sets them to:
> 
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0

Sounds good, and thank you!

							Thanx, Paul

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
