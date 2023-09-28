Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.145.221.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABD374FC
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695922443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X1WRNiJYKhsjhu9PboPlV47UeY0+Yci+Xnu7y1tiVFc=;
	b=g/r81b+lP48tgKKYVhBptJVh8k7zpMEBLSJX60+cMfybQcEnMrn/OYJoxcvNK+/6NTeSk8
	RtDUikpbDIWP7tR9U8tddfCAVP/ePGTu91R0hRN15IoJP3r/v+61tIve9m9Hq2MLNz4mGm
	/AXYj3SI5x6+Xys5j8M//Jq7S9zgTwQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-PukTvQVcMWqAKQ7ZZyw2rA-1; Thu, 28 Sep 2023 13:33:59 -0400
X-MC-Unique: PukTvQVcMWqAKQ7ZZyw2rA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D56B85A5BF;
	Thu, 28 Sep 2023 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69CFE14171B6;
	Thu, 28 Sep 2023 17:33:55 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: iommu@lists.linux.dev,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v2 0/4] AVIC bugfixes and workarounds
Date: Thu, 28 Sep 2023 20:33:50 +0300
Message-Id: <20230928173354.217464-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7

This patch series includes several fixes to AVIC I found while working=0D
on a new version of nested AVIC code.=0D
=0D
Also while developing it I realized that a very simple workaround for=0D
AVIC's errata #1235 exists and included it in this patch series as well.=0D
=0D
changes since v2:=0D
=0D
- added 'fixes' tags=0D
- reworked workaround for avic errata #1235=0D
- dropped iommu patch as it is no longer needed.=0D
=0D
Best regards,=0D
        Maxim Levitsky=0D
=0D
Maxim Levitsky (4):=0D
  x86: KVM: SVM: always update the x2avic msr interception=0D
  x86: KVM: SVM: add support for Invalid IPI Vector interception=0D
  x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()=0D
  x86: KVM: SVM: workaround for AVIC's errata #1235=0D
=0D
 arch/x86/include/asm/svm.h |  1 +=0D
 arch/x86/kvm/svm/avic.c    | 68 +++++++++++++++++++++++++++-----------=0D
 arch/x86/kvm/svm/nested.c  |  3 ++=0D
 arch/x86/kvm/svm/svm.c     |  3 +-=0D
 arch/x86/kvm/svm/svm.h     |  1 +=0D
 5 files changed, 55 insertions(+), 21 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D

