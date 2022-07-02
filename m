Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65C23AA
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656777001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=5g6VsqdC4kG7DLztipNbQU9/3sxDBlsonMJhTJuFq9Q=;
	b=dmI3mumI/S95VpJgODQriI6YVt1h8LlXOyx0umBG8tTvgble+Cj+PxIy0GhmIF5B4xi3qA
	pkH4Q3NZlMC8659Z/9Ve3YBp1yXi5riHm0NQJkaEEVPgZPniOeLfFbR+tDAPFjXLMYBep3
	YUFvLJKhbRstdUXkCAG/AtC2AFX0oEE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-uBg3AIjSOwuVP0k7Nfl2vg-1; Sat, 02 Jul 2022 11:50:00 -0400
X-MC-Unique: uBg3AIjSOwuVP0k7Nfl2vg-1
Received: by mail-qk1-f199.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso4590297qkb.11
        for <iommu@lists.linux.dev>; Sat, 02 Jul 2022 08:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=5g6VsqdC4kG7DLztipNbQU9/3sxDBlsonMJhTJuFq9Q=;
        b=vIBtZoyLdWLWUPRT4x6xS7tPP5i74K3th3A8BFuemfMhzAl59pVSTKrFkRb/Kuv88k
         mSuKrYg1+QM5APrj4n/2BtvqeYUd95t99uN2dRgSGstQgRRuHwQZNz21KbHKKVtEltxK
         Iq4Tm28p6443UjRwYHOuRUtKgPxfWay2QbLx1E4Vf33CtwiCSitNRh2ZdL4mf+AtkxC2
         86J4Qbzqb798y7BtuXc1tmNIWDJH+g+/NGgdq7w0wYFSts3YVToO8R0KOeeFlV7WKXBk
         TPopGOkECyzQaEQJyKn7RJQHbmVShOr1CSpNNGk1ei95dlI7zcZAvr4IQdCLNvOqQq9G
         jgIg==
X-Gm-Message-State: AJIora9IpGfsuQw7kW3wWlt02PW0seTWXzeTUDXFiOt7E0lq8A+FRTWE
	BqY/p3vGMkARtepWNkwRc2kBoTkl0TgHqfiZ8SA2uoVu16n7YlVTL2IcD1GRgBaKNN8ylrj2T1C
	tR4d/mgqICzuWlNhzbtcVY8eRb8G+oOmovcNBbmwMNVgog4bAsvIsfDgCmdJywqe46Zw=
X-Received: by 2002:a05:6214:ca8:b0:46e:7e87:68e2 with SMTP id s8-20020a0562140ca800b0046e7e8768e2mr21081664qvs.76.1656776999533;
        Sat, 02 Jul 2022 08:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ugK5HIvYMAfBfPf08VwjECLD84U6PE77lTFyN5ovSJQzRQIoP7qGrP5g5tLovudmdWuiL78g==
X-Received: by 2002:a05:6214:ca8:b0:46e:7e87:68e2 with SMTP id s8-20020a0562140ca800b0046e7e8768e2mr21081645qvs.76.1656776999191;
        Sat, 02 Jul 2022 08:49:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o23-20020ac84297000000b0031871343473sm14879390qtl.83.2022.07.02.08.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 08:49:58 -0700 (PDT)
Date: Sat, 2 Jul 2022 08:49:56 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Scalable mode and kdump kernels
Message-ID: <20220702154956.x2dxqalzjuzjraxk@cantor>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Apparently there is an issue on Sapphire Rapids if you have the following conditions:

- kernel configured to default to passthrough dma domains, or set it on the command line
- scalable mode enabled

If you force a system crash, there will be a number of DMAR faults
when booting the kdump kernel, with the result being it doesn't mount
the disk and harvest the vmcore.  The fault reason is 0x39, which is no
present bit in the scalable mode root entry.

Looking at the translation table copying code, it looks like what is
there currently is based on the older 2.5 vt-d spec and the extended
root/context entry formats, and doesn't handle the scalable mode
formats. The pasid enabled bit has moved in the scalable mode context
entry from bit 11 to bit 3, and the translation type mode in the root
table address register is different as well. Poking around at it last
night, adding code to deal with those just shifts to the problem to
the present bit in the scalable mode pasid table entry (fault reason
0x59) which isn't copied.

Beyond the translation table copy bits needing to work with scalable
mode formats, should scalable mode force the default dma domain type
to switch to one of the translation modes if the default is passthrough?


Regards,
Jerry

