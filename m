Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23BA37F8DB
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716547; cv=none; b=rAAeNj6G1a6o8BEpWUBZwXvltgjdNxmsNR9DcXz1WXJBCD5YvqOVIba3WjwWaH6TAWzBjZiU9EBLvTruwiVPsmHvIkZUQNtoNENfK3gRd1diahIECKzFrXfc+sMI95BmA0VTIR1tH6bz87xjDXGuxKRZmc2yymUrFSY8JRW/eIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716547; c=relaxed/simple;
	bh=gC5eUqeAebp3PWfUT6EP2kjPnQImFCyW8H71EpslMQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN2nunwZglLRmeww0QKaNdYNWaSAQDxCLLRmU5bmf5u8ZvG1wYtCDte6YACpMncfPDdwCA95/N/b3jqKPXJ/9gazeoz+n998X04Fd4/i/l068mIbNcFiNfT54SPOYkPikmP4qbBLf8UBUCpsV+HZXAGzMquLGSv6LzR//kATMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Y8KNEOjU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Y8KNEOjU"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2a76536bso12443041cf.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783716545; x=1784321345; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fM3Bw1AZy4lAkPPHaL59OrI7vB0RIP/keCGdI0vS7tk=;
        b=Y8KNEOjU05iAKU7TSYKEYWUF5soYf9fExvab3Zk6BFaEGfmsrras5zppLfwO2R0xfA
         Q+9iNXQyhqo/kMLoBRVbZoL82WyNT3c6DJ0SKPPOfkkDCMyH68r0MregpgJy5aQj2wbH
         K7yygdOcD188bFhupTslho2x/ghdMcG2hzrzFeaV24cmvZSpcQg4eT8FX1F9L5Jllp61
         PjCQg+MKf2GkdweQvjxqPEca2AqijT97V2N1a+Ybu0JBSrx4GlVrCIpbNJBBXi11Zlqn
         S4y/QXUk8VRzpQ0QzjFgFBa7W1rzyvAAPqA2diU5mkOtDFHHWY+leD6GKeL87Z/FVRGc
         /J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716545; x=1784321345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fM3Bw1AZy4lAkPPHaL59OrI7vB0RIP/keCGdI0vS7tk=;
        b=rBRK3XPMy+c+QdZcNN8ZuTH0G5R6B+REsGeYuKjfM/48zsTjvhjWzVyI4OqUesgsev
         h7QGKu4ajGmy2McQuWf7wG5CRAsQsn2t3u/IphrSyMV3KCnPs1EfzdVjMtKuyPXQO2fx
         iZlgV4Aejtg4tZ9YeDuoR43YExBokHILtZ3GEpqbuIrssbQQgD+TPESVKOhCaFkrckMt
         YGcVFdYMleJy1ztonKYCr55vxHh1Q++QlOBzT9vqq9Lb7prR0UXIU6rvnTOUvwYySmu4
         jcirnFKpMgQfloDxMXKJY5X8ckm8yTNf2769jk4nz8xruSKmhe7fwFzgmuXery5IauWm
         VkhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdmQjak5EmEcSD7xa9PdpQSYoIv5h4tmWRtSXTZI9fAxuSdjk0iB5IVDhbYSmwmSVteEMU0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3mjpqipH/ZZpnk1eaN3PhbrmzMQylD6i93MSVGUYOH9SuZhby
	wQu+tFKa/EQQHuCT+ExWDbTtiI1eBLd7iC6yKoq8iBH6dX6vPbf46s8qhKjVzaauSHQ=
X-Gm-Gg: AfdE7cle18ikET+SVy9Jhg7dIE9FHEAMMn08kmgATH+k0o3PkVniYBG64G8YsDLMFcm
	s+72I9adw5mS+/vxTRAade8CVEEDdTYD9OHaAknMwzrsq2cHGZXK0GbOMeXwhSoeydhn0mi3yP9
	AodNOkbgzDhhjM9LRdV6MoVRVKi304O31oJN2tgLU21qSNyNpETeFAfQA3sTGEVURlDXCkjSkY/
	oCj3iqEuBkxvrUJl5n+1O2jRadFnp+yWJDsUU2UnvL/oObua7sLD0rg5jKcPCfNh+hLEqzTQ8q7
	f3VKGjl0Zf2oV5PXVdn00v2tTKPKSl14LoKlnpc4tqgY+oiDpNl9iu5zPw0+oL7nrjWQz9Dnbcc
	WJ44VNgfK1JPQHsBqyW3ehMOCqaXqgdHUOquU4zd3xnOIfn/6TopIG8imP3HLO0Q8Zy5MS8Ztxj
	LVfWRK+ifAEFOE9M1TVJYGq1i1+/sRGZTHyk7bvp/nzXSQp2M1wEUNJyL1T63AGwdT3JhX
X-Received: by 2002:a05:622a:15c4:b0:51c:7b11:41a3 with SMTP id d75a77b69052e-51cbf361a3bmr5658901cf.80.1783716544856;
        Fri, 10 Jul 2026 13:49:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf5f61csm24147321cf.22.2026.07.10.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:49:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:48:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 30/30] tools/testing/vma: output compared expression on
 ASSERT_[EQ, NE]()
Message-ID: <alFausURKttxHUAI@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <432444fa4c12ae1c4047550e2b205d3e9bab458f.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432444fa4c12ae1c4047550e2b205d3e9bab458f.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:41PM +0100, Lorenzo Stoakes wrote:
> -#define ASSERT_TRUE(_expr)						\
> -	do {								\
> -		if (!(_expr)) {						\
> -			fprintf(stderr,					\
> -				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
> -				__FILE__, __LINE__, __FUNCTION__, #_expr); \
> -			return false;					\
> -		}							\
> +#define __ASSERT_TRUE(_expr, _fmt, ...)					   \
> +	do {								   \
> +		if (!(_expr)) {						   \
> +			fprintf(stderr,					   \
> +				"Assert FAILED at %s:%d:%s(): %s is FALSE" \
> +				_fmt ".\n",				   \
> +				__FILE__, __LINE__, __FUNCTION__, #_expr   \
> +				__VA_OPT__(,) __VA_ARGS__);		   \
> +			return false;					   \
> +		}							   \
>  	} while (0)
> 
> +#define __TO_SCALAR(x)	((unsigned long long)(uintptr_t)(x))
> +
> +#define ASSERT_TRUE(_expr) __ASSERT_TRUE(_expr, "")

Mmmmm... macro madness.... I don't think this is what you want.

I think you end up double-running the expression in the failure branch.

  ASSERT_EQ(cleanup_mm(&mm, &vmi), 2)

run through the preprocessor expands to:

  do {
      if (!( (cleanup_mm(&mm, &vmi)) == (2) )) {
              **** first run ****

          fprintf(stderr,
              "Assert FAILED at %s:%d:%s(): %s is FALSE" " (0x%llx != 0x%llx)" ".\n",
              "merge.c", 645, __FUNCTION__,
              "(cleanup_mm(&mm, &vmi)) == (2)",
              ((unsigned long long)(uintptr_t)(cleanup_mm(&mm, &vmi))),
                                               **** second run ****

              ((unsigned long long)(uintptr_t)(2)));
          return false;
      }
  } while (0);


A bunch of existing ASSERT callers mutate state, so there's no guarantee
the printed value matches teh actual test value.

I think you want something like:

#define ASSERT_EQ(_val1, _val2) do {	\
	__auto_type _v1 = (_val1);	\
	__auto_type _v2 = (_val2);	\
	__ASSERT_TRUE(_v1 == _v2, " (0x%llx != 0x%llx)",	\
		__TO_SCALAR(_v1), __TO_SCALAR(_v2));	\
} while (0)

which expands to:

  do {
      __auto_type _v1 = (cleanup_mm(&mm, &vmi));
      __auto_type _v2 = (2);
      do {
          if (!(_v1 == _v2)) {
              fprintf(stderr, "...FALSE (0x%llx != 0x%llx).\n",
                      "merge.c", 645, __FUNCTION__, "_v1 == _v2",
                      ((unsigned long long)(uintptr_t)(_v1)),
                      ((unsigned long long)(uintptr_t)(_v2)));
              return false;
          }
      } while (0);
  } while (0);

~Gregory
