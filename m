Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8577BE7C
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 08:37:13 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1687250226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnki0r5y4TroSJ8P6p+PySOa093W7Oqe6Ng8UJe+axY=;
	b=hTZCKfB0Dm0qkGSiW0lNQniI9H/ypBbK7XnHzIc5Wwxs9kiU1bYYKN1DCX73COz8El7lMD
	8xfUtjV7cwd0WLJNkhTh17eB7bVthya5jhWunDMV78HExnjqeBj0OUeD8Xq9e/1AMhvJw2
	iseST0n/ECErlpj0huXQ7hSNp+6zbeewlnRpl/wxviFKgHyUIQkllbQVQ4Xznqb37Ywx5f
	Qqzi+TVZsG+PyNX3p0HAIkRlR0outyujAcjrhaIue/bDvgd+tbQvghO4y3A5FtjcHmLYuS
	Ek3XJZCQn+zMr6blc5ym9tm5qvEEZZVEh9fY5qX50MDwBP2qFoFsU2SKRzP83g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1687250226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnki0r5y4TroSJ8P6p+PySOa093W7Oqe6Ng8UJe+axY=;
	b=fom0Ekn1nFU9HjMfw1gEd0/2MwYHr82fLAnc+vgq8OJvpEvu6ubNuyRjR3ADXM7DS+wvFE
	LljsU4/9A0poFpCw==
To: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, iommu@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-perf-users@vger.kernel.org,
 x86@kernel.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, steve.wahl@hpe.com, mike.travis@hpe.com,
 dimitri.sivanich@hpe.com, russ.anderson@hpe.com, dvhart@infradead.org,
 andy@infradead.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 will@kernel.org, robin.murphy@arm.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, peterz@infradead.org,
 acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, xin3.li@intel.com, seanjc@google.com,
 jiangshanlai@gmail.com, jgg@ziepe.ca, yangtiezhu@loongson.cn
Subject: Re: [PATCH 2/3] x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a
 timer callback
In-Reply-To: <20230619231611.2230-3-xin3.li@intel.com>
References: <20230619231611.2230-1-xin3.li@intel.com>
 <20230619231611.2230-3-xin3.li@intel.com>
Date: Tue, 20 Jun 2023 10:37:05 +0200
Message-ID: <87h6r2pm1a.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 19 2023 at 16:16, Xin Li wrote:
> +/*
> + * Called with vector_lock held
> + */

Such a comment is patently bad. 

> +static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
>  {
        ....

        lockdep_assert_held(&vector_lock);

Documents the requirement clearly _and_ catches any caller which does not
hold the lock when lockdep is enabled.

Thanks,

        tglx
