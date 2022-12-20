Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322131383
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 05:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98797C433D2;
	Tue, 20 Dec 2022 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671515523;
	bh=k6yHixLVE3U9pNLPDWoHZ8KCCDWLbUAFeGls6uMNDVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4qNxFEfAoICReXUu76kgpqClyhio4C1oWONukCsmPCtnJMTXqLKY/m0Zs8UuFTZM
	 g5pDbnx7DvNBykzHCq4TlDro7TQyNy/534mmFbSOTdvL5jKkLzTnUTjBSJNabIwgiJ
	 exdOfYcQMkl9Y+BJ0s6BqbBOupPanLr5iAAi4rQcTU9beGwI7FspZO42Jj/YleWHxQ
	 lHx6k8EG785snbOE8YixAvsAeO3IOEGbbEHiouhdS5KAa9YYOuVFPAaBGcVx/Mr+ux
	 qnboVZ01KM2R7CpAc6cboF8ArJaT18WLDGgLa66+eDIzC8ifHTQpDxOMBXFAmlYv00
	 qpNuFncUWMCBQ==
Date: Mon, 19 Dec 2022 21:52:00 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
	boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com,
	dennis@kernel.org, tj@kernel.org, cl@linux.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 03/12] cyrpto/b128ops: Remove struct u128
Message-ID: <Y6FNgNQ8/I9uqYwc@sol.localdomain>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.022180444@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.022180444@infradead.org>

On Mon, Dec 19, 2022 at 04:35:28PM +0100, Peter Zijlstra wrote:
> cyrpto/b128ops: Remove struct u128

cyrpto => crypto

> Per git-grep u128_xor() and its related struct u128 are unused except
> to implement {be,le}128_xor(). Remove them to free up the namespace.

There's still a reference to u128 in drivers/crypto/vmx/ghash.c.  But, it's only
dereferenced by assembly code, so it should keep working even if u128 gets
redefined to a native int.  I don't speak PowerPC, so I'm not sure what the
"correct" type is there.

- Eric
