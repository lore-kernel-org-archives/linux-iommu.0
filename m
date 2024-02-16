Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF3179AB
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072708; cv=none; b=h8dtuse+M1yv7BRo5MMaHIL6eJm5/lpPwPy8U5yPnDS0ZVLnkhdOMNKGa/4QXQlCx3ObWoMxTYG/seQXSDq5V9l/RFu1hggv6OBwk6WveBjPeCtFSWUTf4ceuIjag37nDlTbhcQ+qaLvl8T5U5h70vPSErvwMBbAd6svRsTF0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072708; c=relaxed/simple;
	bh=HxOuetD/ZDxORTouQxar11u838Ki34k7zzeCS5xykLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M3AEWxZYtl3mgdoMs4b7hxHVWskIwtBXF4tazZ4A+VLIBPU0HTGLOBpUyKVoRBTuZ/+R6i3qFnrgXwkesPvJMR5NipNmZscvf4Ieu+OyhycdiRfkLOLkbj4HS8dyNsAi1Lu3Peq7nE/R+Q7uTC0AJyf9tvxBWEZf5eUPln76Nzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdnL6q2I; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdnL6q2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708072707; x=1739608707;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HxOuetD/ZDxORTouQxar11u838Ki34k7zzeCS5xykLA=;
  b=LdnL6q2Il8PcIxQVk6h5kWafjAWtLRqAZBuZBbgjsCZgN8SHcUcwTPVi
   Q70Twhme+ELQuMVTze8WoqNDdnq8hGUKmNr9IUJB5O3Cm26E+DPr6HFha
   QAx664vLRxLERaIxQsoIzrfsMQ+2/XleSmy4WPJiVCt/0c+J5pPOh9ln5
   RDRv3bW4IF9YuhWvVe11KU2B61QcfwkRAmMHgcMfy6NQXFMGz58nib+8L
   CNbDX4FHCSz8Ku8YUX3d383oSF5tWIvTVY1mBmLOEqtJKSMzM8u0pwqKO
   5Zji4mZht9eIWV/dEszVDopCQToO5fHCQj2wvHKBcoEJSWEaMQ3ESqxgN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2063352"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2063352"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="4144870"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.79])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:38:04 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com, peterz@infradead.org,
 juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240212213922.783301-1-surenb@google.com>
Date: Fri, 16 Feb 2024 10:38:00 +0200
Message-ID: <87sf1s4xef.fsf@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 12 Feb 2024, Suren Baghdasaryan <surenb@google.com> wrote:
> Memory allocation, v3 and final:
>
> Overview:
> Low overhead [1] per-callsite memory allocation profiling. Not just for debug
> kernels, overhead low enough to be deployed in production.
>
> We're aiming to get this in the next merge window, for 6.9. The feedback
> we've gotten has been that even out of tree this patchset has already
> been useful, and there's a significant amount of other work gated on the
> code tagging functionality included in this patchset [2].

I wonder if it wouldn't be too much trouble to write at least a brief
overview document under Documentation/ describing what this is all
about? Even as follow-up. People seeing the patch series have the
benefit of the cover letter and the commit messages, but that's hardly
documentation.

We have all these great frameworks and tools but their discoverability
to kernel developers isn't always all that great.

BR,
Jani.


-- 
Jani Nikula, Intel
