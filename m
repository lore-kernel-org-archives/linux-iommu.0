From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v4 3/9] iommu/amd: Detect pre enabled translation
Date: Mon, 30 May 2016 11:27:33 +0800
Message-ID: <20160530032733.GC2488@x1.redhat.com>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
 <1464157735-8865-4-git-send-email-bhe@redhat.com>
 <3371fab6-b3db-6f4a-a1a1-b272c3f8fdbe@iommu.org>
 <20160530032407.GB2488@x1.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160530032407.GB2488@x1.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, vincent.wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com
List-Id: iommu@lists.linux-foundation.org

On 05/30/16 at 11:24am, Baoquan He wrote:
> On 05/28/16 at 08:49pm, Wan Zongshun wrote:
> In fact I am still debugging and trying to figure out what need be done
> further to stop the IO_PAGE_FAULT happened on ethernet network card. I
> kept changing code and adjust the patches. Up to now seems I still
> didn't figure out why. There must be something I didn't notice and
> everything will be fine as soon as I close that valve. With my
> understand pci bug scanning will detect each pci device and do the
 		 |_ bus
> initialization job like setting configuration space registers and
> control registers. After that we can safely re-init the pci device and
> re-install the new io-page tables, and this is how Joerg has done for
> vt-d fix for kdump if my understanding is correct. And I tried to do
> like that in this patchset, don't know why it doesn't work.
