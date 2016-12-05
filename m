From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] Documentation/core-api/device_link: Add initial
 documentation
Date: Mon, 5 Dec 2016 14:15:28 -0700
Message-ID: <20161205141528.1c0e9f52@lwn.net>
References: <cover.1480849144.git.lukas@wunner.de>
        <f5b568e349aaeb31039a0c4d01fdb05d8b3bdd2a.1480849144.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <f5b568e349aaeb31039a0c4d01fdb05d8b3bdd2a.1480849144.git.lukas@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sun, 4 Dec 2016 13:10:04 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> Document device links as introduced in v4.10 with commits:
>     4bdb35506b89 ("driver core: Add a wrapper around
>                    __device_release_driver()")
>     9ed9895370ae ("driver core: Functional dependencies tracking
>                    support")
>     8c73b4288496 ("PM / sleep: Make async suspend/resume of devices use
>                    device links")
>     21d5c57b3726 ("PM / runtime: Use device links")
>     baa8809f6097 ("PM / runtime: Optimize the use of device links")

I went ahead and applied this one to docs-next.  I did, however, take the
liberty of shifting it over to the driver-api manual.

Thanks,

jon
