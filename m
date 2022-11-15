Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9542F31
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 10:14:42 +0000 (UTC)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ousxh-0004BE-Dw; Tue, 15 Nov 2022 11:14:37 +0100
Message-ID: <563f0162-ae94-0d74-bb25-1c0753af9329@leemhuis.info>
Date: Tue, 15 Nov 2022 11:14:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] hwmon/coretemp: Simplify platform device antics
Content-Language: en-US, de-DE
To: Robin Murphy <robin.murphy@arm.com>, fenghua.yu@intel.com,
 jdelvare@suse.com, linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, janusz.krzysztofik@linux.intel.com,
 lucas.demarchi@intel.com
References: <898dbb76a54aae6ca58ceefcab9ab18beeee2fff.1668096928.git.robin.murphy@arm.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <898dbb76a54aae6ca58ceefcab9ab18beeee2fff.1668096928.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668507282;c3ceb43f;
X-HE-SMSGID: 1ousxh-0004BE-Dw

On 10.11.22 17:20, Robin Murphy wrote:
> Coretemp's vestigial platform driver is odd. All the real work is done
> globally by the initcall and CPU hotplug notifiers, while the "driver"
> effectively just wraps an allocation and the registration of the hwmon
> interface in a long-winded round-trip through the driver core. The whole
> logic of dynamically creating and destroying platform devices to bring
> the interfaces up and down is fatally flawed right away, since it
> assumes platform_device_add() will synchronously bind the driver and set
> drvdata before it returns, thus results in a NULL dereference if
> drivers_autoprobe is turned off for the platform bus. Furthermore, the
> unusual approach of doing that from within a CPU hotplug notifier is
> also problematic. It's already commented in the code that it deadlocks
> suspend, but it also causes lockdep issues for other drivers or
> subsystems which may want to legitimately register a CPU hotplug
> notifier from a platform bus notifier.
> 
> All of these issues can be solved by ripping this questionable behaviour
> out completely, simply tying the platform devices to the lifetime of the
> module itself, and directly managing the hwmon interfaces from the
> hotplug notifiers. There is a slight user-visible change in that
> /sys/bus/platform/drivers/coretemp will no longer appear, and
> /sys/devices/platform/coretemp.n will remain present if package n is
> hotplugged off, but hwmon users should really only be looking for the
> presence of the hwmon interfaces, whose behaviour remains unchanged.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

For future archeologists and the regression tracking this afaics should
have the following tags, as outlined by the documentation[1].

Link:
https://lore.kernel.org/lkml/20220922101036.87457-1-janusz.krzysztofik@linux.intel.com/
Link: https://gitlab.freedesktop.org/drm/intel/issues/6641

Any maybe a reported-by for Janusz, too.

Ciao, Thorsten

[1] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

P.S.:

#regzbot ^backmonitor:
https://lore.kernel.org/lkml/20220922101036.87457-1-janusz.krzysztofik@linux.intel.com/

