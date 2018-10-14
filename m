From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
Date: Sun, 14 Oct 2018 08:49:40 -0400
Message-ID: <CAP8WD_ZANLea11JtbbV+i0W8VDn4gsV2tDPPLRDsybHk-PEHCQ@mail.gmail.com>
References: <20181014075208.2715-1-hch@lst.de> <alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de>
 <20181014081443.GA17889@lst.de> <alpine.DEB.2.21.1810141055440.1438@nanos.tec.linutronix.de>
 <20181014090433.GA28319@gmail.com>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181014090433.GA28319@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>, x86@kernel.org, konrad.wilk@oracle.com, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Please change:

Reported-by: tedheadster <tedheadster@gmail.com>
Tested-by: tedheadster <tedheadster@gmail.com>

to

Reported-by: Matthew Whitehead <tedheadster@gmail.com>
Tested-by: Matthew Whitehead <tedheadster@gmail.com>

- Matthew
