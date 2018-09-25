From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 18/20] iommu/tegra: gart: Don't detach devices from
	inactive domains
Date: Tue, 25 Sep 2018 16:41:55 +0300
Message-ID: <57704439-66f3-2548-093c-b5a2fc04ee14@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-19-digetx@gmail.com> <20180924110047.GO21032@ulmo>
	<8be80297-3b13-ece6-a5bf-873cc7877989@gmail.com>
	<20180925100424.GG7097@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180925100424.GG7097@ulmo>
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

On 9/25/18 1:04 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 09:05:48PM +0300, Dmitry Osipenko wrote:
>> On 9/24/18 2:00 PM, Thierry Reding wrote:
>>> On Mon, Sep 24, 2018 at 03:41:51AM +0300, Dmitry Osipenko wrote:
>>>> There could be unlimited number of allocated domains, but only one domain
>>>> can be active at a time. Hence devices must be detached only from the
>>>> active domain.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>  drivers/iommu/tegra-gart.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> Do we have a mechanism of switching out different domains? I don't think
>>> we do, so I'm wondering if perhaps a better solution to this would be to
>>> just refuse to create more than one domain in the first place. That
>>> would also allow us to get rid of the global variable gart_handle.
>>
>> That's what was done in v1, Robin Murphy suggested that it will be
>> better not to restrict allocation of unpopulated domains. It is
>> mentioned in the changelog, see comment to v2 changes.
> 
> Okay, fine.

Thanks, taking as ACK.
