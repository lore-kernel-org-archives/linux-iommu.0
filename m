From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 17/20] iommu/tegra: gart: Prepend error/debug messages
	with "GART:"
Date: Mon, 24 Sep 2018 21:09:36 +0300
Message-ID: <32307503-bbd5-6ccc-39bd-b956465a9977@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-18-digetx@gmail.com> <20180924105714.GN21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924105714.GN21032@ulmo>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 9/24/18 1:57 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:50AM +0300, Dmitry Osipenko wrote:
>> GART became a part of Memory Controller, hence now the drivers device
>> is Memory Controller and not GART. As a result all printed messages are
>> prepended with the "tegra-mc 7000f000.memory-controller:", so let's
>> prepend GART's messages with "GART:" in order to differentiate them
>> from the MC.
>>
>> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/iommu/tegra-gart.c | 36 ++++++++++++++++++------------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> There's a macro called dev_fmt (similar to pr_fmt) to do this for dev_*
> printers. Also I think this would be more readable if the prefix was
> "gart: " rather than "GART: ". At least from my personal experience I
> get easily distracted by all-caps words in logs, because they usually
> indicate something that requires immediate attention. I think it's
> better to leave that up to higher level mechanisms, such as the color
> keying of messages based on level by tools like dmesg.

The dev_fmt is a new thing, thank you for pointing at it. I'll try to
switch to dev_fmt and lower the text case.
