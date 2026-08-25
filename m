Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6248C3E3
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679015; cv=none; b=D/kDvVhJq8S4Y5CnA1YHjo7RNWOPnvZ0Navy/IvY2R+B1b3+DiqBTktesd5LYsIWhiv9joRgTphLacdrLPnnIQG2mQOij6oaHQBvWLB7ZTQpByBULNZHPy3JdssMcjzuZyCcosSXxI3M+Rja8pN9FfyaOqciEdiPnWOu78oP7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679015; c=relaxed/simple;
	bh=WF09Bx2mtfrt6hRVd0SLFSWF4rEJup3wBMbdU8OJyJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMfF1OUtcdKLrhnmtlx0k7GfW88qzNWcuZfiB5oBa4KiL2DLpDHskUYaFyjuRfLlzBnPJWABMY0xlrO03GFMSNIExvVzi7+8yiFkzl+20irPeeSGc62u+G+L416Z/BgqPD6wWvsPCdDwACqvhGMJkP+6TOl/3SVXVTzHv/hTf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1BH/euZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1BH/euZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d3b445a84fso6145ad.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787679006; x=1788283806; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8wBJpCqawgcwqwfKU05d1Z2ZrVuf5nK5DNpdSKbZyiM=;
        b=W1BH/euZEBwdEEYBa4x4NK/qjalOxXX1yDiQ+w/uJxIK8wi5MzSrbq8dSsJkZPqmQ9
         iBA8n9EMAAHXogyU4VDh8fYewN9HECsRLbXsD186IbxHUM/KeN3PAbE51t+SsuOF5q8P
         7fMvMBq7JFlO9x2f5NHnfZ9cmuHQQFsy0cm3zcB/ztq0xTzBYdkycg3HCoMgKr46d3IG
         qHp/Xs7JPTpZCM5tOL0tjBbBz7yc14j3S8r53y1k6V/YttLO7HjctxdIRbb7Fna5/lU2
         bVWyyRe2i4AY9dVB3OevbDEjnAghP3KgD/PqxE1YwhRzEjwm3YxQ+sPtqqhqBX0QceB+
         Yytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787679006; x=1788283806;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wBJpCqawgcwqwfKU05d1Z2ZrVuf5nK5DNpdSKbZyiM=;
        b=EeRIjsBpEyYBkZuSi3k+wFCVTTryAkHx675qzv9BgdVe6Yi+KGkkG+sG1eKZD67pyl
         zmvDxJgXi348LachiOeRf4L0DxyuHf30D86Y0lbjVUdttj0gC9Ip9Qe7XGTEepVwLzlb
         CGz/24Eu85Ict0RVMVX4jIl9nrWB7U2lSq5Go/yJN9K0rJU1pQ6F13+tlNecd6MGvlQZ
         KM7ex1/gp3O6KRLFB/b9EBPgeKdfGnjLcCVKNuqBQ+30V7pjFTtV3ZQFtXAkvbp13pRD
         ni5l2Ds3VRF0HQ9GbeTRkBJhNwDA5/NlBVLFcIifSkD7Gx2rc9kq0Mv4jZr1Tx9V1wMY
         MWQQ==
X-Gm-Message-State: AFuF++ndSOngjOuX1ShpGqywR1cQX+v7C7JwzQG/xK0RM/hWWLmwEUto
	1MMFH2VORmu+uBSQy86jMQxiE1LDNNzxvURvPy+SFwoK0YfCdLz5SwBN06aodp20gw==
X-Gm-Gg: AR+sD12Fs4/AxECQs0PwHMSx8JcNM46XhCbHOWCKZcSdNNqFBROAatogml1+LaC2+nA
	ySJo+Vi7xQvickVyAg1Tz4PgSEHUvznFsIyyKC2q/21pNx2ihRDAwSyPykLePrGisTbdg4NYa5/
	7R++2ejgZip694V08b+koFr4GaWBj22REu0myEC7YqJ1Z2CDQHcBCOYh5lZXyEGSUZgNPDqtNfU
	zM1/wZyBhxykSa06zvA6Su+3MxBmPdVm9jzrt7loP8OX4zy5r+zpesQRkrdE5tTBuCh7p15BCo+
	d3Gv+SAZEcEvmljXU24kJ6r7ii6XgVzqmk9AywexWzz8xaRfcmO3FWZOoP5q3xxg7Aq+1rsRWfQ
	G+q/AlO0HVqhnUStWdq9M2+xHtbwdVuH+ETlCte43Ypn7GL0StDmamc2GTKUqo5miFP47PhC+wY
	lEaYKLZ1GOJvICtLQg0p9IvnSTDfQvSYRtBO3jlywWcEPpQr06mAcq6mn0Vqy3YlYiI4FeW9cIg
	wTPC2EJORxoCNSoL9zNAkP4zJBWtKcVvcNF3w==
X-Received: by 2002:a17:903:acf:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2d6e036d4cbmr8058505ad.0.1787679005676;
        Tue, 25 Aug 2026 10:30:05 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39662c80d6csm1544432a91.1.2026.08.25.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:30:05 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:29:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <ao3RF0w_AXo5EXxv@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com>
 <20260825114916.GT244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825114916.GT244917@nvidia.com>

On Tue, Aug 25, 2026 at 08:49:16AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 10:32:07AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > > > [ ... 52 lines skipped ... ]
> > > > +/*
> > > > + * Invalidate a DTE by clearing the Valid bit first.
> > > > + * Note: Lockless; Not to be used on a fully probed
> > > > + * device with live dev_data.
> > > > + */
> > > > +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> > > > +{
> > > > +	struct dev_table_entry new = {};
> > > > +
> > > > +	write_dte_lower128(ptr, &new);
> > > > +	write_dte_upper128(ptr, &new);
> > > > +}
> > > 
> > > No need just call update_dte256() with a 0'd new. This is how all the
> > > update flows work, and it flushes the DTE which this looks like it has
> > > been missing all long.
> > 
> > I originally considered using update_dte256(), but iommu_disable_device
> > is called from the early probe error path (err_deinit).
> 
> There is no reason to do that, the DTE isn't written by
> amd_iommu_probe_device(), so there is no reason to clear it on an
> error path.
> 
> It is wrong to write to the DTE table without flushing the
> HW cache.
> 

I agree, but I wonder why the existing code used memset here 
(in ignore_device):

memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));

I was thinking it might've been done for probe failures in a kdump
kernel (normal kexec would've called shutdown for clearing all DTEs).
(I see this was added long time back and existed when PCI segments were
added [1]).

Are you suggesting to remove the DTE clearing from this path entirely?

Thanks,
Praan

[1] https://lore.kernel.org/all/20220706113825.25582-23-vasant.hegde@amd.com/
