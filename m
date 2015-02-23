From: =?windows-1252?Q?Vincent_Stehl=E9?= <vincent.stehle@laposte.net>
Subject: Re: [PATCH linux-next] iommu: Enable LPAE pagetable on ARM only
Date: Tue, 24 Feb 2015 00:36:10 +0100
Message-ID: <54EBB96A.4050401@bergerie>
References: <1424621346-7822-1-git-send-email-vincent.stehle@laposte.net> <2868840.GyWYJOzqWH@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <2868840.GyWYJOzqWH@avalon>
Sender: linux-next-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

On 02/23/2015 05:52 PM, Laurent Pinchart wrote:
(runtime warning)
> I suppose this is caused by the selftest code ?

Hi Laurent,

Thanks for your feedback. You are right, this is the selftest code. Here
are the traces just before the first warnings:

  arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 32^M
  arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 36^M
  arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 40^M

There are a number of failed selftests and warnings, and in the end the
PA-RISC machine won't boot.

..
> How about ARM || COMPILE_TEST ? It can still be useful to compile the module 
> on other architectures.

I think you are right and this is how it should be; thank you for the
tips, I did not know about COMPILE_TEST. I'll resend a patch v2 right away.

Best regards,

V.
