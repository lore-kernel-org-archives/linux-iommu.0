Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7112F37B
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936284; cv=none; b=revc/OUbOv4Ag0kOJr7HwewjduewtTZFVBiX+25Lxkmu/5F/AxKCHBCdYpNSzx4DMJzcMeE3ikzB3eBEjpsjEVBkST04+h3E4F/NWm6QDES6dyyVhF84KpJRNFVjhVuFfHkRWmowjlgfRb3oKgERJ+C1EC0ByjP8CWqdDroW5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936284; c=relaxed/simple;
	bh=KFBiMaQU/PxUVXVt4KYkyObRHLVGfa0+L/fkok95v0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtBPQuB5c+Zj6zQ+EKlKccD54sDCqaRAnb/FnlamHTU1VoG2qo2+Xbs9FVUIUnbv6lAN/c8xEFEhdFYAHQa7vQ77uNHScmxVSn3cXdwGFM34CZi25AChOXuTKosTcCFB9TRNh/pFliqA5DGJOHupb4JAupIyW1EpyQm5LdO1Lfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1850750"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1850750"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617408"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617408"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 10:44:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B4D90204; Wed, 14 Feb 2024 20:44:33 +0200 (EET)
Date: Wed, 14 Feb 2024 20:44:33 +0200
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <Zc0KEfoCVvP1kWvA@black.fi.intel.com>
References: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-1-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:46PM -0800, Suren Baghdasaryan wrote:
> Memory allocation, v3 and final:

Would be nice to have --base added to cover letter. The very first patch
can't be applied on today's Linux Next.

-- 
With Best Regards,
Andy Shevchenko


