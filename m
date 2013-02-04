From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: PCI warning on boot 3.8.0-rc1
Date: Mon, 4 Feb 2013 10:36:45 -0800
Message-ID: <20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
 <CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org


> I think drivers/pci/search.c is identical between 3.7 and 3.8-rc1.  Is
> this the first time you've turned on the IOMMU on that box?

It exists in 3.7 and earlier kernels, just haven't turned on same config.

> It's the same warning as in this bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=44881, and there's a patch
> there at https://bugzilla.kernel.org/show_bug.cgi?id=44881#c11, but
> it's just a quirk that turns off VT-d if we find certain broken
> bridges.  It doesn't look like you have any of those (although I don't
> know what you have at 05:00.0).
> 
> Bjorn

This is a standard ASUS motherboard, and don't want to disable VT-d.
