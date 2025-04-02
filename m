Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026EFC0A
	for <iommu@lists.linux.dev>; Wed,  2 Apr 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555042; cv=none; b=VlM6IdD/2NTfo6VVw9FYrByx9jRYn/uNZh6CuO6zUlK8Pvyxlj01tlQMmB5TigmHP9eD70JTtXME1NpD91Rq8Ki3TVBX7X/EqnLQDZENUytb4xVE9OU0AA1tcCqjG7XKBl077voZzlwyr+6d/vShyv0leCh3U4dJyrlg05ORHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555042; c=relaxed/simple;
	bh=2HtuutMy+lDMR+2ROadl7v745BYRGRRdl+H5LeHcAUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ga4YI+Fm1K3HxBgPOyoPRipVgaEQHlQ6g+ZW+q+jnrX6WMQCZP4MrgzXWrK5XZlWx4zJNy/Y/LfhrcN+krjw7SEpHTOkZZ6+6Zd+gTy0GACehbisSq3WydYQty7Eql2MlhmNMM5Nx8w6EQ0w07nAev6xbK8hnaXQYh5HzzmKWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIIItgVb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIIItgVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743555039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJTNg57TpFxM6eiCchcjLRtnNvCRkiMrbkIi/jphXdc=;
	b=TIIItgVbpSg/V0KNFBlMqpQUfZyabexSPBcCH9ubMHI//R7pzVnGv9sCmLu/oPb9dJytsC
	xkOYSAGBmwyqmQuuo3CDTZMGv4e5qbt6MwPE6pLctScoUOCN23TaaeofWXU7mr/QEzv7Ej
	IK5CZXch5/cQMJNI1MScfBkFoDjq7QM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-6asSha_BOf-spkOW3mgUCA-1; Tue, 01 Apr 2025 20:50:38 -0400
X-MC-Unique: 6asSha_BOf-spkOW3mgUCA-1
X-Mimecast-MFC-AGG-ID: 6asSha_BOf-spkOW3mgUCA_1743555037
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso16919464a91.0
        for <iommu@lists.linux.dev>; Tue, 01 Apr 2025 17:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743555036; x=1744159836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJTNg57TpFxM6eiCchcjLRtnNvCRkiMrbkIi/jphXdc=;
        b=PWxF/1rkEBq3rJ7csaRwQfxtNPheUbLJutkfj62OWZ+mo0YcNfk1T/6fVWQ6UXZrg+
         eTfKoo+JtE+8MBV7p42wI4lXQWZ42W7TmG6mPDyT0FhD1I4j1caicy6ozyvG7d503Ziq
         it7/w44NmLDq3wm8vJQccNRxlm+iDzdLVW7Kv8nC9IOJwps37XUWjU/eZH4qwgR0C2ZT
         0Tk1rSGnoSRadJTp7ovoTfK5jha0uYcrTf+i6AFaB8FB78rVX19SE7xrcnRCcQ2yjk5p
         giLOE7PcyMkCXbOOqe/cz9YmRSuPL5EOoKnjRLnbxA9jQUzMe4Q2MncWY4LGp3HXIAHm
         mf+g==
X-Forwarded-Encrypted: i=1; AJvYcCXW4V4/hgE68tOaJSH/ma6RKfO57pJ2C/BeeZLJsg5opMRuzgREdnwAeDJZFQjETgOxKB5W8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQeR+k/iJGO6MK+MMkVWf/BINQzQhXyYRDZVk1qgl8TLSvVIfD
	CS05g3mkxlBKKMWNn/v8OXfeCFS4MIqe/qEczScQWjGxEx0mMEb+jjYgalRhLWpyMFv20EShbQg
	Ay3UvbiWaDSgZ1LBtYPF+JSrhNcyH5ZqzjFRZ6mVQflz5OfBKNIg7F/LI7zC+
X-Gm-Gg: ASbGncstbNBhnpFAUCauQfyx6cJvR48ac9vxd5EChfxSWhQOQ1/aJB385xuKjKU0vET
	cAfDGxgmyTbIBQf31QpXcX3JFjf7s1k0mDt3aDisYf6F+g/tjr8AJduEU3/u009IFDH5jV2Yt8x
	CxNCK38AfdV+hU40vEnrAhanihJNRvJjhGmNu55g/iPiRdQY97/Nh/w+P8x9AxhiyZ/1xaQ6Bs8
	H5qUIzg1Hamd3lB2OQFRKVvrta+o/rU2HLsHLLONjh2IywhE24pKKYf9ang5833yCYV8A==
X-Received: by 2002:a05:6a20:d04e:b0:1f5:730b:e09a with SMTP id adf61e73a8af0-200e4c4f75fmr590018637.20.1743555036441;
        Tue, 01 Apr 2025 17:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdk1FxrJ+9cINgByDopFSozFjxckoY96NPi7m/sZgKLt5ACht/tUy31f50xwZLM8tQpD7l1Q==
X-Received: by 2002:a05:6a20:d04e:b0:1f5:730b:e09a with SMTP id adf61e73a8af0-200e4c4f75fmr590003637.20.1743555036171;
        Tue, 01 Apr 2025 17:50:36 -0700 (PDT)
Received: from jpoimboe ([2600:1700:6e32:6c00::1e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b8acb9esm8768221a12.54.2025.04.01.17.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 17:50:35 -0700 (PDT)
Date: Tue, 1 Apr 2025 17:50:32 -0700
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] iommu: Convert unreachable() to BUG()
Message-ID: <6zzyjtvkqc4ipj7ngtkx3jithfwpwuxlix677urlehgdnljwbl@wfoa5futari6>
References: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>
 <20250327123718.GB31358@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250327123718.GB31358@noisy.programming.kicks-ass.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: orn4TXwUSAh5YkXt2YBQzbUyk2Q_i-BgYiqPiDVJazw_1743555037
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Mar 27, 2025 at 01:37:18PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 26, 2025 at 10:28:46PM -0700, Josh Poimboeuf wrote:
> > Bare unreachable() should be avoided as it generates undefined behavior,
> > e.g. falling through to the next function.  Use BUG() instead so the
> > error is defined.
> 
> Right; I did a pass like this a while ago and thought I'd removed all
> unreachable() abuse.

Any reason not to just "#define unreachable() BUG()" and convert UD2 and
similar to use __builtin_unreachable()?

-- 
Josh

