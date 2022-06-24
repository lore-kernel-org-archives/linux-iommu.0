Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D812A7C
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 10:21:40 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A740721982;
	Fri, 24 Jun 2022 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656066092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2o//5RsBBP4Q3Y91eiwaePN5wmGbpiIFxxYpkXu0ZYE=;
	b=O4tm8iaMwSHu7ldBuiOY3Elnh25wFyZ7CO1Np57zyckcwbNLwUjGFIfBe47zwAUB8KGjed
	BM+UX85MO9dLfcnS0r7gBEhxEAeTWifOrYCZ8VnHSdYxk6shATkvn4CrKt5yCo1YGaz56t
	1wOQkxQ+fHRsZ2e7NveJ5q67TCOjW0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656066092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2o//5RsBBP4Q3Y91eiwaePN5wmGbpiIFxxYpkXu0ZYE=;
	b=g3osGxy0Z3so5e0NMyBNVREKmUrFXe4Bc1ptB8YZmasy9nWMFNoJWl9XKORLjHxtPrXOIP
	7n3ksU1XW+E8SwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EBD413ACA;
	Fri, 24 Jun 2022 10:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id K3NaGSyQtWKSJAAAMHmgww
	(envelope-from <jroedel@suse.de>); Fri, 24 Jun 2022 10:21:32 +0000
Date: Fri, 24 Jun 2022 12:21:31 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Add new IOMMU development mailing list
Message-ID: <YrWQK32lXdyzVheR@suse.de>
References: <20220622082601.31678-1-joro@8bytes.org>
 <YrVZ7g3AKzoI0uMG@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrVZ7g3AKzoI0uMG@infradead.org>
Message-ID: <20220624102131.gUlnPsl5Z6l9m8Br9_qH9ZXmqf9TuWFO71TZvufkWw8@z>

On Thu, Jun 23, 2022 at 11:30:06PM -0700, Christoph Hellwig wrote:
> iommu@lists.linux-foundation.org is also listed for various other
> MAINTAINERS entries.  Can you please send a list to update all of them
> to Linus ASAP, including for 5.19 and -stable?

Right, will do, thanks for the heads-up.

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

