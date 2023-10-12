Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E617F5
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie0+d04T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697122022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXGRPt6ZIkBsn4GXcOAW4CPcCkYLP5pOVPWADq3b9M4=;
	b=ie0+d04Tf03ca08Dn55Fc/sLusKX8IcM/b+UfA3v4GdC4D6WsDj0OyeImmOwCSMSNdzUiw
	ezQrCmLzcS7RuZCCuXnmwfWWWPNQxa5O4Ah+JlPFexvE+Ej0HQYdLbz8xDQjN6ihtYdvNh
	U1dePjJ4g+QFLSEne+uUapaI2617pQ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-ltUzLKs0O26ZcyOSchQSAQ-1; Thu, 12 Oct 2023 10:46:49 -0400
X-MC-Unique: ltUzLKs0O26ZcyOSchQSAQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73AEC101AA72;
	Thu, 12 Oct 2023 14:46:48 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E508640611D;
	Thu, 12 Oct 2023 14:46:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	"H . Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Joerg Roedel <joro@8bytes.org>,
	x86@kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/4] AVIC bugfixes and workarounds
Date: Thu, 12 Oct 2023 10:46:40 -0400
Message-Id: <20231012144639.1354427-1-pbonzini@redhat.com>
In-Reply-To: <20230928173354.217464-1-mlevitsk@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10

Queued patches 1-3, thanks.

Paolo


