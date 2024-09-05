Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08F1A0B06
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555608; cv=none; b=ROB7qnTcIpc/fyd3MHP7aNIhEpXUzi2aQE4KxLsKTy/zUJZp2Fm5+pBlDRuC27febocvSsM8/zDjL27ZDeMI2en386rxXH/COTQZ7WZkyH/fNHCa3T4zim5iYzb+7S7M9Jh7UqGxzklI3El8vZwqjbi48fsDCnwgznDgMyw1ae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555608; c=relaxed/simple;
	bh=kUKvlt9oQSc6GPz4Rg0Q1sVBZUSpr7XakOpAwQN1cdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPAcsCt4gQwCeQvBkWsDHgoPJdkgDOdS2vRRjaQO4Dog0FU4ZWzeuUVL9hMVq24DemVj5Qwsalj5P2O9cetvvyQJlfhNaaI06zPfpFFOXcmqTjUQBDy1/AXfLJYdQ/w2NI5afLuKimH8R5hLCsRXzTZ6eCFItkeVCQXr1FYEqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EGoN38GO; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EGoN38GO"
Message-ID: <3559cb54-b19a-4650-afc0-fcfb261dd876@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725555602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWNOpx6m4x/ajgnWUaYsJDrWvzMaA+fdW54bnTwX/Yw=;
	b=EGoN38GO6M9zHBXiuq121lA5BBZ+Sr3PpplTj3KGRFBSgvNKzxXEJ5ANgHTpO1mYeu2qSG
	TITC4D+AgCNp8uFDhGUZFZ6TJXPjoGZfdOdfWf9L9xiOVhZSSg+LepRsby7/GHYBP+dysM
	Urq63M6XIWrUsxlHqhx6HeD88Usc2dM=
Date: Thu, 5 Sep 2024 12:59:50 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v3] dma: Trace API
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <20240826203240.2234615-1-sean.anderson@linux.dev>
 <20240829041912.GB4408@lst.de>
 <4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev>
 <20240903072512.GA1521@lst.de> <20240903092154.5f0bfafe@gandalf.local.home>
 <d8936bfc-1ea3-4142-8035-0dfb8e491c31@linux.dev>
 <20240903205322.69d7638c@gandalf.local.home>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240903205322.69d7638c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/3/24 20:53, Steven Rostedt wrote:
> On Tue, 3 Sep 2024 10:36:29 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> This doesn't apply for arrays:
>> 
>> 	field:__data_loc u64[] addrs;	offset:12;	size:4;	signed:0;
>> 
>> Here the size is not for the data type but for the array. And so the
>> type is parsed by process_sizeof in src/event-parse.c.
> 
> Ah, I see what you are talking about:
> 
> +	TP_printk("%s dir=%s phys_addrs=%s attrs=%s",
> +		__get_str(device),
> +		decode_dma_data_direction(__entry->dir),
> +		__print_array(__get_dynamic_array(addrs),
> +			      __get_dynamic_array_len(addrs) /
> +				sizeof(unsigned long long), sizeof(unsigned long long)),
> +		decode_dma_attrs(__entry->attrs))
> 
> That part.
> 
> Yeah, the "sizeof()" parsing is somewhat of a hack. It would be trivial to
> add u64 and all the variants to that.
> 
> This should do. I could get it into the next minor version.
> 
> diff --git a/src/event-parse.c b/src/event-parse.c
> index ddeb3b9909c0..73563c8e9dea 100644
> --- a/src/event-parse.c
> +++ b/src/event-parse.c
> @@ -3571,6 +3571,23 @@ process_sizeof(struct tep_event *event, struct tep_print_arg *arg, char **tok)
>  			/* The token is the next token */
>  			token_has_paren = true;
>  		}
> +
> +	} else if (strcmp(token, "__u64") == 0 || strcmp(token, "u64") == 0 ||
> +		   strcmp(token, "__s64") == 0 || strcmp(token, "s64") == 0) {
> +		arg->atom.atom = strdup("8");
> +
> +	} else if (strcmp(token, "__u32") == 0 || strcmp(token, "u32") == 0 ||
> +		   strcmp(token, "__s32") == 0 || strcmp(token, "s32") == 0) {
> +		arg->atom.atom = strdup("4");
> +
> +	} else if (strcmp(token, "__u16") == 0 || strcmp(token, "u16") == 0 ||
> +		   strcmp(token, "__s16") == 0 || strcmp(token, "s16") == 0) {
> +		arg->atom.atom = strdup("2");
> +
> +	} else if (strcmp(token, "__u8") == 0 || strcmp(token, "u8") == 0 ||
> +		   strcmp(token, "__s8") == 0 || strcmp(token, "s8") == 0) {
> +		arg->atom.atom = strdup("1");
> +
>  	} else if (strcmp(token, "REC") == 0) {
>  
>  		free_token(token);

The above patch fixes the issue for me. Feel free to add

Tested-by: Sean Anderson <sean.anderson@linux.dev>

when you send it.

--Sean
