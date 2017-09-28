From: Joerg Roedel <jroedel@suse.de>
Subject: Re: intel-dmar: possible circular locking dependency detected
Date: Thu, 28 Sep 2017 15:41:21 +0200
Message-ID: <20170928130107.kjjegfuxf6gwtpqm@suse.de>
References: <4e9f9665-38f7-c5f0-2a9d-13bb3a00aab2@siemens.com>
 <6ed4183a-b2eb-b8d3-c54c-fb0c4fd7a813@siemens.com>
 <82afec06-4eb9-7b91-7b19-c442b77b5769@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <82afec06-4eb9-7b91-7b19-c442b77b5769@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hey Jan,

On Wed, Sep 27, 2017 at 04:19:15PM +0200, Jan Kiszka wrote:
> On 2017-09-27 15:21, Jan Kiszka wrote:
> > On 2017-09-27 14:14, Jan Kiszka wrote:
> >> while I'm triggering this with a still out-of-tree module from the
> >> Jailhouse project, the potential deadlock appears to me being unrelated
> >> to it. Please have a look:

Thanks for the report. I'll have a look soon.



Regards,

	Joerg
