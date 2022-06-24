Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E028EB
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 13:28:03 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF2FB1F8EC;
	Fri, 24 Jun 2022 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656076812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y20EeLE8B8Qorbwu1g9EchQUnf3UdaJEcN6H691i3xI=;
	b=heWHZ0JvOaO8n8TxQZNpBsw0yMM9P7PxY9qwv9Zrwg/9dcfUBCoRZooPZB96T3ekAhObzh
	A989zpuVbyzC3p7QZ2WGWQGwfcO2fdpSICEshUQam4HXDQrG5WyJdEoZguCTmCqPKkBv1D
	szw8nukiSMFs/nkSyvQGIHuSjiy6uDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656076812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y20EeLE8B8Qorbwu1g9EchQUnf3UdaJEcN6H691i3xI=;
	b=rZtFUCKz0dNLJzLgqkNg2tJ3kGf8eJOy91IHH6i0HZFIa61eFh+hid9kLHPDXQd4CH8QpF
	YGEAzXe9newKqzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C46E13480;
	Fri, 24 Jun 2022 13:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NTqPHAy6tWKJfQAAMHmgww
	(envelope-from <jroedel@suse.de>); Fri, 24 Jun 2022 13:20:12 +0000
Date: Fri, 24 Jun 2022 15:20:11 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add new IOMMU development mailing list
Message-ID: <YrW6C4AgJ9U5tcfF@suse.de>
References: <20220624125139.412-1-joro@8bytes.org>
 <YrW1Oy0ojM5pXREB@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrW1Oy0ojM5pXREB@infradead.org>
Message-ID: <20220624132011.HMVhpwHyxJE73ppQHrFdFK5Xyh87skgvUxmZ6VhySzo@z>

On Fri, Jun 24, 2022 at 05:59:39AM -0700, Christoph Hellwig wrote:
> Shouldn't this also remove the old list given it has only a few days
> to live?

No, the new list is not yet archived on lore. There will be a hard
switch of the archive on July 5th, and after that the old list can be
removed.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

