From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/4] pci: Add PCI_BUS() and PCI_DEVID() interfaces to
 return bus number and device id
Date: Tue, 26 Mar 2013 22:59:44 +0100
Message-ID: <20130326215944.GB30540@8bytes.org>
References: <1362009978.2808.33.camel@lorien2>
 <CAErSpo6DjjSKCFL6CjmqkOAyc1iU1TG1=n=K=AXPcU_r6ZdPGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo6DjjSKCFL6CjmqkOAyc1iU1TG1=n=K=AXPcU_r6ZdPGA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: shuah.khan@hp.com, Jiang Liu <jiang.liu@huawei.com>, "shemminger@vyatta.com" <shemminger@vyatta.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Kerrisk-manpages <mtk.manpages@gmail.com>, iommu@lists.linux-foundation.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuahkhan@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

On Tue, Mar 26, 2013 at 03:41:07PM -0600, Bjorn Helgaas wrote:
> Since some of these touch drivers/iommu, it'd be good if you acked
> them again, Joerg.  I know you acked them before, but there have been
> minor changes since then, so I didn't add your ack to these.  But if
> you're still OK with them, I'll refresh the branch to add it now.

Looks still good to me. You can add my

Acked-by: Joerg Roedel <joro@8bytes.org>

if you want.


	Joerg
