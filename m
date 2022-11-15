Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3443C2D
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 12:49:51 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id z14so23929312wrn.7
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 04:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4OAPFPv9ICweMhHmhi9nXFzX1GVFUwibSbuKpM22sU=;
        b=coF6qCD4Sv4T1AgerOOvdy+szNlwl9BpAoSyaj7uFwTuEIRIt1mHnFHHZTG3gJWjCa
         P7dsYyf/dV+7XKS0G2t7Ihpro4cv3PewWCEnDRud76rchVoa0YCUlhH2uJOBGSl/ycZF
         XgfuwI0gJUfdfGJHfwQzWYodSvYTWMH7AcGxa2QSInISvjJ0gqq5j39HGJOo5bc5z/nR
         IJnH/1k14ojcHtD4cIpxkC4dgFyDf4Oc0b/MTdkl45AutwEbcUd3oUauVnMi6OPb01oS
         iIYE1pDS8/nniiW8t8eU6M0jVuWHfqp0ELuTixuFDdaELq9HyjFXDMieyXhaV747Q2pO
         YK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4OAPFPv9ICweMhHmhi9nXFzX1GVFUwibSbuKpM22sU=;
        b=AgqiFGZ/m/UFcGoD3xhUXWiy94/nQz7ahixapdPcfMBuoGrqYyxijxFhmsg6elw+aA
         5rFwdpulMkmskMEKYzYV63uvdcltkZhsRos0fSs547m+jxw0ydRseRuojHHcSCU+4Fzt
         vXIcqcKQYNflAtt3Qi++gZF7YFT/lI8S86eKxpwaUvFZJ57r0FzVuSoveYc4DWcgSxZq
         HwhOgGNJs4YXgPFHS/tyiM9uDQdCQUrcpU1zY25p/HrRkJCZzE8V00sthh00H+C5O3yF
         ayCfMVNFyPkiaJPNNqNZIQFZ5/XQtCO3cWONrvlU/GpRILNBZsyfZz1X3mVBLh+5gDvT
         Zzuw==
X-Gm-Message-State: ANoB5pm+QVIFUULD2CUbN19LDIZySxLtIOWPJ69/JbEYvukqMw0fw/C+
	VHxCRdJBaQYIE5HY2nqGel9wwMrfj4A=
X-Google-Smtp-Source: AA0mqf7wc7sJxYIRlbcHllDD5oSli4Km4zN133Mc1HsvGWsgy5pBwMhO0uoVEiVR/N9SWPoheLvpFA==
X-Received: by 2002:a05:6000:108b:b0:22e:68a1:ddab with SMTP id y11-20020a056000108b00b0022e68a1ddabmr10610951wrw.496.1668516589818;
        Tue, 15 Nov 2022 04:49:49 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b00236c1f2cecesm14896265wrs.81.2022.11.15.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:49:49 -0800 (PST)
Date: Tue, 15 Nov 2022 15:49:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: jgg@ziepe.ca
Cc: iommu@lists.linux.dev
Subject: [bug report] iommufd: Add a selftest
Message-ID: <Y3OK6DeM6X4q5JWO@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jason Gunthorpe,

The patch 147393321d65: "iommufd: Add a selftest" from Nov 19, 2021,
leads to the following Smatch static checker warning:

	drivers/iommu/iommufd/selftest.c:160 mock_domain_map_pages()
	warn: use 'gfp' here instead of GFP_XXX?

drivers/iommu/iommufd/selftest.c
   133  static int mock_domain_map_pages(struct iommu_domain *domain,
   134                                   unsigned long iova, phys_addr_t paddr,
   135                                   size_t pgsize, size_t pgcount, int prot,
   136                                   gfp_t gfp, size_t *mapped)
   137  {
   138          struct mock_iommu_domain *mock =
   139                  container_of(domain, struct mock_iommu_domain, domain);
   140          unsigned long flags = MOCK_PFN_START_IOVA;
   141          unsigned long start_iova = iova;
   142  
   143          /*
   144           * xarray does not reliably work with fault injection because it does a
   145           * retry allocation, so put our own failure point.
   146           */
   147          if (iommufd_should_fail())
   148                  return -ENOENT;
   149  
   150          WARN_ON(iova % MOCK_IO_PAGE_SIZE);
   151          WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
   152          for (; pgcount; pgcount--) {
   153                  size_t cur;
   154  
   155                  for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
   156                          void *old;
   157  
   158                          if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
   159                                  flags = MOCK_PFN_LAST_IOVA;
   160                          old = xa_store(&mock->pfns, iova / MOCK_IO_PAGE_SIZE,
   161                                         xa_mk_value((paddr / MOCK_IO_PAGE_SIZE) |
   162                                                     flags),
   163                                         GFP_KERNEL);
                                               ^^^^^^^^^^
"gfp" isn't used anywhere so maybe it was intended here?



   164                          if (xa_is_err(old)) {
   165                                  for (; start_iova != iova;
   166                                       start_iova += MOCK_IO_PAGE_SIZE)
   167                                          xa_erase(&mock->pfns,
   168                                                   start_iova /
   169                                                           MOCK_IO_PAGE_SIZE);
   170                                  return xa_err(old);
   171                          }
   172                          WARN_ON(old);
   173                          iova += MOCK_IO_PAGE_SIZE;
   174                          paddr += MOCK_IO_PAGE_SIZE;

regards,
dan carpenter
